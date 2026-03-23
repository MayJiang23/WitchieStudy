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
