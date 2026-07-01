package com.example.preditech_ecu_sim

import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothServerSocket
import android.bluetooth.BluetoothSocket
import android.os.Handler
import android.os.Looper
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import java.io.IOException
import java.io.InputStream
import java.io.OutputStream
import java.util.UUID

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.preditech.ecu/bluetooth_server"
    private val EVENT_CHANNEL = "com.preditech.ecu/bluetooth_events"

    private var serverThread: AcceptThread? = null
    private var connectedThread: ConnectedThread? = null
    private var eventSink: EventChannel.EventSink? = null

    // Standard SPP UUID
    private val MY_UUID: UUID = UUID.fromString("00001101-0000-1000-8000-00805F9B34FB")

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, EVENT_CHANNEL).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    eventSink = events
                }

                override fun onCancel(arguments: Any?) {
                    eventSink = null
                }
            }
        )

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "startServer" -> {
                    if (serverThread == null) {
                        serverThread = AcceptThread()
                        serverThread?.start()
                        result.success(true)
                    } else {
                        result.success(true)
                    }
                }
                "stopServer" -> {
                    serverThread?.cancel()
                    serverThread = null
                    connectedThread?.cancel()
                    connectedThread = null
                    result.success(true)
                }
                "sendData" -> {
                    val data = call.argument<String>("data")
                    if (data != null && connectedThread != null) {
                        connectedThread?.write(data.toByteArray(Charsets.US_ASCII))
                        result.success(true)
                    } else {
                        result.error("NOT_CONNECTED", "No active connection or null data", null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    private inner class AcceptThread : Thread() {
        private val mmServerSocket: BluetoothServerSocket? by lazy(LazyThreadSafetyMode.NONE) {
            val bluetoothAdapter = BluetoothAdapter.getDefaultAdapter()
            try {
                // Insecure to allow connections without explicit pairing sometimes, but secure is fine too.
                bluetoothAdapter?.listenUsingInsecureRfcommWithServiceRecord("ECUSimulator", MY_UUID)
            } catch (e: SecurityException) {
                null
            } catch (e: IOException) {
                null
            }
        }

        override fun run() {
            var shouldLoop = true
            while (shouldLoop) {
                val socket: BluetoothSocket? = try {
                    mmServerSocket?.accept()
                } catch (e: IOException) {
                    shouldLoop = false
                    null
                }
                socket?.also {
                    // Manage the connection in a separate thread
                    connectedThread?.cancel()
                    connectedThread = ConnectedThread(it)
                    connectedThread?.start()
                }
            }
        }

        fun cancel() {
            try {
                mmServerSocket?.close()
            } catch (e: IOException) {
            }
        }
    }

    private inner class ConnectedThread(private val mmSocket: BluetoothSocket) : Thread() {
        private val mmInStream: InputStream = mmSocket.inputStream
        private val mmOutStream: OutputStream = mmSocket.outputStream
        private val handler = Handler(Looper.getMainLooper())

        override fun run() {
            val buffer = ByteArray(1024)
            var bytes: Int
            
            while (true) {
                try {
                    bytes = mmInStream.read(buffer)
                    if (bytes > 0) {
                        val readMessage = String(buffer, 0, bytes, Charsets.US_ASCII)
                        handler.post {
                            eventSink?.success(readMessage)
                        }
                    }
                } catch (e: IOException) {
                    break
                }
            }
        }

        fun write(bytes: ByteArray) {
            try {
                mmOutStream.write(bytes)
            } catch (e: IOException) {
            }
        }

        fun cancel() {
            try {
                mmSocket.close()
            } catch (e: IOException) {
            }
        }
    }
}
