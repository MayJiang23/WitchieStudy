import SwiftUI
import UniformTypeIdentifiers

struct InventoryItem: Identifiable, Hashable, Codable {
    let id: UUID
    let itemDef: ItemDef {
        return GameRegistry.shared.get()
    }
    var quantity: Int
    var price: Int
}
