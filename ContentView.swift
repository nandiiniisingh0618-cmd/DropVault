import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var networkManager = VaultNetworkManager()
    @State private var isBroadcasting = false
    @State private var messageText = ""
    @State private var sharedSecret = "SRM-SECURITY-KEY" 
    let securityGreen = Color(red: 0.0, green: 1.0, blue: 0.0)

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Text("DROPVAULT").font(.custom("Menlo", size: 28).bold()).foregroundColor(securityGreen)
                Toggle("SECURE BROADCAST", isOn: $isBroadcasting).padding().foregroundColor(.white)
                    .onChange(of: isBroadcasting) { networkManager.toggleBroadcasting(isOn: isBroadcasting) }
                
                if let data = networkManager.lastReceivedData {
                    let key = CryptoEngine.deriveKey(from: sharedSecret)
                    if let decrypted = try? CryptoEngine.decrypt(data, key: key) {
                        Text("RECEIVED: \(decrypted)").foregroundColor(securityGreen).padding()
                    }
                }

                Spacer()
                HStack {
                    TextField("Enter payload...", text: $messageText).padding().background(Color.white.opacity(0.1)).cornerRadius(8).foregroundColor(.white)
                    Button("SEND") {
                        let key = CryptoEngine.deriveKey(from: sharedSecret)
                        if let encrypted = try? CryptoEngine.encrypt(messageText, key: key) {
                            networkManager.sendData(encrypted)
                            messageText = ""
                        }
                    }.foregroundColor(.black).padding().background(securityGreen).cornerRadius(8)
                }.padding()
            }
        }
    }
}