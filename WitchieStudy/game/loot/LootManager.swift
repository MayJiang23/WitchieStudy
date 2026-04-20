import SwiftUI
import UniformTypeIdentifiers

struct LootManager {
    var inventory: InventoryManager

    let lootChance: Double = 0.4
    let possibleItems = [
        InventoryItem(id: UUID(), name: "Magic Potion", icon: "flask.fill"),
        InventoryItem(id: UUID(), name: "Steel Shield", icon: "shield.fill"),
        InventoryItem(id: UUID(), name: "Gold Coin", icon: "bitcoinsign.circle")
    ]
    
    func attemptLoot() -> InventoryItem? {
        let roll = Double.random(in: 0...1)
            
        if roll <= lootChance {
            if let newItem = possibleItems.randomElement() {
                return newItem
            }
        } else {
            print("Luck wasn't on your side this time.")
            return nil
        }
        return nil
    }
}
