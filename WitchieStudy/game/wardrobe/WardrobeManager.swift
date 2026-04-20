import Foundation
import SwiftData

@Observable
class WardrobeManager {
    var wardrobe: [WardrobeCategory: [ClothingItem]] = [:]
    var equipped: [WardrobeCategory: ClothingItem] = [:]
    var playerManager: PlayerCharacterManager?
    
    func equip(_ item: ClothingItem) {
        equipped[item.category] = item
        playerManager?.equipItem(item)
    }
    
    func unequip(_ category: WardrobeCategory) {
        equipped.removeValue(forKey: category)
        playerManager?.unequipItem(category)
    }
}
