# DropVault 🔐

A secure, peer-to-peer encrypted messaging app for iOS built with SwiftUI and Apple's Multipeer Connectivity framework. DropVault lets nearby Apple devices discover each other automatically and exchange AES-GCM encrypted payloads — no internet required.

---

## Features

- **Peer-to-peer discovery** — Devices on the same local network or proximity are found automatically via `MultipeerConnectivity`
- **End-to-end encryption** — All payloads are encrypted with AES-GCM using Apple's `CryptoKit` before transmission
- **SHA-256 key derivation** — A shared secret is hashed into a symmetric encryption key
- **Real-time receive display** — Incoming encrypted data is decrypted and displayed instantly
- **Broadcast toggle** — Start and stop advertising/browsing with a single switch
- **Terminal-style dark UI** — Monospaced font, black background, security-green accents

---

## Tech Stack

| Layer | Technology |
|---|---|
| UI | SwiftUI |
| Persistence | SwiftData |
| Networking | MultipeerConnectivity |
| Cryptography | CryptoKit (AES-GCM, SHA-256) |
| Language | Swift |
| Observability | `@Observable` macro |

---

## Project Structure

```
DropVault/
├── ContentView.swift         # Main UI — broadcast toggle, message input, receive display
├── VaultNetworkManager.swift # MultipeerConnectivity session, advertiser, and browser
├── CryptoEngine.swift        # AES-GCM encrypt/decrypt and SHA-256 key derivation
└── TransferLog.swift         # Transfer history logging (SwiftData model)
```

---

## How It Works

1. **Key Derivation** — A shared secret string is hashed with SHA-256 to produce a `SymmetricKey`.
2. **Broadcasting** — When enabled, the app simultaneously advertises itself and browses for nearby peers over the `drop-vault` Multipeer service.
3. **Connection** — Found peers are invited automatically; accepted invitations are required encryption.
4. **Send** — The user's message is AES-GCM encrypted with the derived key and sent as raw `Data` to all connected peers.
5. **Receive** — Incoming data is decrypted on the main thread and rendered in the UI.

---

## Getting Started

### Requirements

- Xcode 15+
- iOS 17+ (uses `@Observable` and SwiftData)
- Two or more physical Apple devices (Multipeer Connectivity does not work in the Simulator)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/nandiiniisingh0618-cmd/DropVault.git
   ```
2. Open the project folder in Xcode (create a new Xcode project and add the Swift files, or set up an Xcode project manually).
3. Set your development team in **Signing & Capabilities**.
4. Build and run on two physical iOS devices.

### Usage

1. Launch DropVault on two nearby iOS devices.
2. Toggle **SECURE BROADCAST** on both devices.
3. The devices will discover and connect to each other automatically.
4. Type a message in the payload field and tap **SEND**.
5. The receiving device will display the decrypted message in real time.

> **Note:** Both devices must use the same shared secret (`SRM-SECURITY-KEY` by default) for decryption to succeed. Update the `sharedSecret` value in `ContentView.swift` to use a custom key.

---

## Security Notes

- Encryption uses **AES-GCM** (authenticated encryption), which provides both confidentiality and integrity.
- The Multipeer session is initialized with `.encryptionPreference: .required`, enabling Apple's built-in transport-layer encryption on top of the application-layer AES-GCM.
- The default shared secret is hardcoded for demonstration purposes. In a production app, this should be exchanged out-of-band or derived via a key-agreement protocol (e.g., Diffie-Hellman).

---

## License

This project is open source. See the repository for license details.
