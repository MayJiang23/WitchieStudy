import SwiftData
import Foundation

@Model
class SaveableEntity: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    var blueprintId: String //This is used to look up anything inside the registry (static json files)
    
    init(blueprintId: String) {
        self.blueprintId = blueprintId
    }
    
    func captureSnapshot() -> AnyCodable {}
}

extension SaveableEntity {
    static func createDefault(_ blueprintId: String) -> SaveableEntity {
        return SaveableEntity(blueprintId: blueprintId)
    }
}
