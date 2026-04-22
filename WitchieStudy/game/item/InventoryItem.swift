import SwiftUI
import UniformTypeIdentifiers

struct InventoryItem: Identifiable, Hashable, Codable {
    let id: UUID
    let itemDef: ItemDef
    var quantity: Int
    var price: Int
}
