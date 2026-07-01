<div align="center">
  <img src="app icon (2).png" alt="Preditech ECU Simulator Logo" width="150" />
  <h1>Preditech ECU Simulator</h1>
  <p><strong>Advanced ELM327 / OBD-II Hardware Simulator for Mobile & Desktop</strong></p>

  <p>
    <a href="https://flutter.dev"><img src="https://img.shields.io/badge/Made%20with-Flutter-02569B.svg?style=flat-square&logo=Flutter" alt="Made with Flutter" /></a>
    <a href="https://dart.dev"><img src="https://img.shields.io/badge/Language-Dart-0175C2.svg?style=flat-square&logo=dart" alt="Language Dart" /></a>
    <img src="https://img.shields.io/badge/Platform-Android%20%7C%20Windows-brightgreen.svg?style=flat-square" alt="Platforms" />
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
