import SwiftUI
import UniformTypeIdentifiers

struct InventoryItem: Identifiable, Hashable, Codable {
    let id: UUID
    var name: String
    var icon: String
}
