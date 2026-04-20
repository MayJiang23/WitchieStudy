import Foundation

struct SaveEnvelope {
    var saveTime: Date
    let data: AnyCodable
    
    init(_ data: AnyCodable) {
        self.saveTime = Date.now
        self.data = data
    }
}
