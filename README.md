<div align="center">
  <img src="assets/images/app_icon.png" alt="Preditech ECU Simulator Logo" width="150" />
  <h1>Preditech ECU Simulator</h1>
  <p><strong>Advanced ELM327 / OBD-II Hardware Simulator for Mobile & Desktop</strong></p>

  <p>
    <a href="https://flutter.dev"><img src="https://img.shields.io/badge/Made%20with-Flutter-02569B.svg?style=flat-square&logo=Flutter" alt="Made with Flutter" /></a>
    <a href="https://dart.dev"><img src="https://img.shields.io/badge/Language-Dart-0175C2.svg?style=flat-square&logo=dart" alt="Language Dart" /></a>
    <img src="https://img.shields.io/badge/Platform-Android%20%7C%20Windows%20%7C%20Linux-brightgreen.svg?style=flat-square" alt="Platforms" />
  </p>
</div>

---

## 📖 Overview

**Preditech ECU Simulator** is a complete software replacement for physical ELM327 / OBD-II scanner hardware. Instead of sitting in a real car and plugging an OBD-II device into the dashboard, developers and automotive enthusiasts can use this simulator to generate real-time telematics data (Speed, RPM, Engine Load, Coolant Temp, DTCs) and serve it to diagnostic apps (like *Car Scanner*, *Torque*, or custom telematic clients) over **Bluetooth (SPP)** or **Wi-Fi**.

### ✨ Key Features

- 🚗 **Real-Time Vehicle Telemetry:** Live simulation of RPM, Speed, Engine Load, Coolant, and Voltage.
- 📡 **Multi-Protocol Connectivity:**
  - **Bluetooth SPP:** Acts as a classic Bluetooth serial port (Android/Windows).
  - **Wi-Fi:** Runs a TCP socket server (Port 35000) accessible over LAN.
- 🛠️ **DTC (Diagnostic Trouble Codes) Injection:** Dynamically inject pending and stored error codes to test diagnostic apps.
- 🗄️ **Multi-Vehicle Profiles:** Save and load custom telemetry configurations (e.g., "Sports Car", "Truck").
- 💻 **Cross-Platform:** Beautifully runs on both **Android** and **Windows** desktop environments.

---

## 🏗️ How It Works (Architecture)

The simulator is built with a decoupled architecture in Flutter. It consists of three main layers:

1. **The Server Layer (Connection Services):**
   - **`BluetoothServer`**: Uses native Bluetooth RFCOMM SPP to emulate an ELM327 dongle on Android.
   - **`SerialServer`**: Overcomes Windows Bluetooth limitations by connecting to virtual "Incoming COM Ports" via `flutter_libserialport` utilizing aggressive asynchronous polling.
   - **`WifiServer`**: Opens a standard TCP socket (`0.0.0.0:35000`) for network-based OBD-II connections.
2. **The ELM327 Logic Core (`Elm327Simulator`):**
   - Acts as the brain. It intercepts AT commands (e.g., `ATZ`, `ATE0`, `ATSP0`), parses OBD-II PIDs (e.g., `010C` for RPM, `010D` for Speed), and calculates the correct hex payload responses according to SAE J1979 standards.
3. **The UI/ViewModel Layer:**
   - Provider-based ViewModels (`ConnectionViewModel`, `SimulatorViewModel`, `DtcViewModel`) reactively update the beautiful custom Neumorphic / Glassmorphic UI, allowing the user to scrub sliders and inject faults.

---

## 🚀 Getting Started (For Developers)

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Version 3.19+ recommended)
- Android Studio / Visual Studio 2022 (with "Desktop development with C++" workload)

### 1. Installation

Clone the repository and install dependencies:

```bash
git clone https://github.com/Polygen/ecu-simulator.git
cd ecu-simulator
flutter pub get
```

### 2. Running on Android

Simply run on an attached Android device. Note: Bluetooth servers cannot run on the iOS simulator or Android Emulator natively; a physical Android device is highly recommended for Bluetooth testing.

```bash
flutter run -d android
```

### 3. Running on Windows

Due to Windows' restriction on native Bluetooth SPP server creation, we use Virtual COM Ports.

```bash
flutter run -d windows
```

#### 🔧 Windows Bluetooth Setup Guide
To test Bluetooth on Windows, you must bridge a virtual COM port:
1. Go to **Windows Settings > Bluetooth & devices > More Bluetooth options**.
2. Go to the **COM Ports** tab.
3. Click **Add** and select **Incoming (Gelen)**.
4. Windows will assign a COM Port (e.g., `COM4`).
5. Open the Preditech Simulator, select "COM Port (BT)", pick `COM4`, and hit Start!

### 4. Running on Linux

Linux uses BlueZ's `rfcomm` tool to bridge Bluetooth SPP into a virtual serial port that the existing `SerialServer` reads from. **No new native code** — `flutter_libserialport` already enumerates `/dev/rfcomm*` devices.

#### 🐧 Linux Bluetooth Setup Guide (Arch / Manjaro / CachyOS)

**1. Install Bluetooth packages:**

BlueZ 5.65+ removed `rfcomm` and `sdptool` from the main `bluez-utils` package. Install the deprecated tools to get them back:

```bash
sudo pacman -S bluez bluez-utils bluez-deprecated-tools
sudo systemctl enable --now bluetooth.service
```

**2. Pair the phone with the computer (once):**

```bash
bluetoothctl
# Inside the bluetoothctl shell:
power on
scan on
# Wait for your phone's MAC to appear, then:
pair AA:BB:CC:DD:EE:FF
trust AA:BB:CC:DD:EE:FF
exit
```

**3. Register the SPP service (only needed on some setups):**

```bash
sudo sdptool add SP
```

**4. Start the rfcomm listener in a separate terminal:**

```bash
sudo rfcomm listen /dev/rfcomm0 1
```

You should see: `Waiting for connection on channel 1`. Leave this terminal open.

**5. (Optional but recommended) udev rule for persistent permissions:**

Without this rule, only `root` can read/write `/dev/rfcomm0` and you'd need `sudo` for the app (which is not advised for a desktop app).

Create `/etc/udev/rules.d/99-rfcomm.rules`:

```
KERNEL=="rfcomm[0-9]*", TAG+="uaccess"
```

Then reload rules:

```bash
sudo udevadm control --reload-rules && sudo udevadm trigger
```

**6. Run the app:**

```bash
flutter run -d linux
```

Inside the app: pick **"Bluetooth (rfcomm)"**, select `/dev/rfcomm0` from the dropdown, hit **"Sunucuyu Başlat"**.

> 💡 **Tip:** Each rfcomm channel is single-client. If you need multiple simultaneous clients, run multiple `rfcomm listen` calls on different numbers (`/dev/rfcomm0`, `/dev/rfcomm1`, ...).

#### 🔌 End-to-End Test

1. From your phone, pair and connect to the computer via Bluetooth (use Car Scanner, Torque, OBD Auto Doctor, or any ELM327 client).
2. The rfcomm terminal should print `Connected /dev/rfcomm0 to ...`.
3. The app's log panel will start showing `Rx: ...` and `Tx: ...` lines.
4. Send `ATZ`, `ATE0`, `ATSP0` from the client — expect `ELM327 ...`, `OK`, `OK`.
5. Send `010C` (RPM) and `010D` (Speed) — expect `41 0C XX XX` and `41 0D XX` based on the simulator's current slider values.

---

## 🤝 Contributing

We welcome contributions to expand the simulated PID list, add new UI themes, or improve core logic!

1. **Fork** the repository.
2. **Create a branch:** `git checkout -b feature/cool-new-pid`
3. **Commit your changes:** `git commit -m 'Add support for MAF sensor simulation'`
4. **Push:** `git push origin feature/cool-new-pid`
5. **Open a Pull Request.**

### Areas for Future Development
- Support for **CAN Bus** raw frame simulation.
- Extended **Mode 09** (Vehicle Info) customization.
- **iOS support** via BLE (Bluetooth Low Energy) GATT simulation.

---

<div align="center">
  <p>Built with ❤️ by Polygen & Antigravity</p>
</div>
