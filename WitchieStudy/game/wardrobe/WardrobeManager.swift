import Foundation
import SwiftData

@Observable
class WardrobeManager {
    var wardrobe: [WardrobeCategory: [ClothingItem]] = [:]
    var equipped: [WardrobeCategory: ClothingItem] = [:]
    
    func equip(_ item: ClothingItem) {
        equipped[item.category] = item
    }
}
