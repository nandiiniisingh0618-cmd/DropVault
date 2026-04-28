import Foundation
import CryptoKit

struct CryptoEngine {
    static func deriveKey(from sharedSecret: String) -> SymmetricKey {
        let data = sharedSecret.data(using: .utf8)!
        let hashed = SHA256.hash(data: data)
        return SymmetricKey(data: hashed)
    }

    static func encrypt(_ text: String, key: SymmetricKey) throws -> Data {
        let data = text.data(using: .utf8)!
        let sealedBox = try AES.GCM.seal(data, using: key)
        return sealedBox.combined!
    }

    static func decrypt(_ data: Data, key: SymmetricKey) throws -> String {
        let sealedBox = try AES.GCM.SealedBox(combined: data)
        let decryptedData = try AES.GCM.open(sealedBox, using: key)
        return String(data: decryptedData, encoding: .utf8) ?? "Error"
    }
}