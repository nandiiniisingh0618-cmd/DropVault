import Foundation
import SwiftData

@Model
final class TransferLog {
    var timestamp: Date
    var peerName: String
    var messagePreview: String
    var isIncoming: Bool
    
    init(timestamp: Date = Date(), peerName: String, messagePreview: String, isIncoming: Bool) {
        self.timestamp = timestamp
        self.peerName = peerName
        self.messagePreview = messagePreview
        self.isIncoming = isIncoming
    }
}