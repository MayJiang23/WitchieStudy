import UniformTypeIdentifiers
import Foundation
import SwiftData


@Model
class Inventory: Identifiable {
    var id: UUID
    var slots: [InventoryItem?]
    
    init(slots: [InventoryItem?] = [])
    {
        self.id = UUID()
        self.slots = slots
    }
}

extension Inventory {
    static func createDefault() -> Inventory {
        var slots = Array<InventoryItem?>(repeating: nil, count: 15)
        return Inventory(slots: slots)
    }
}
