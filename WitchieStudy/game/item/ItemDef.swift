import SwiftUI
import UniformTypeIdentifiers

struct ItemDef: Identifiable, Hashable, Codable {
    let id: String
    var name: String
    var iconKey: String
    var stackable: Bool
    var maxStack: Int
}
