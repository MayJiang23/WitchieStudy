import Foundation

struct GiftResult {
    let xpGained: Int
    let tierUp: Bool
    let newTier: RelationTier?
    let characterName: String
}

struct GiftService {
    static let baseXP = 10
    static let preferredBonusMultiplier = 3

    /// Gift an inventory item to an NPC character.
    /// Removes the item from inventory, calculates XP, and updates the relationship.
    static func giftItem(
        item: InventoryItem,
        to character: GameCharacter,
        inventory: InventoryManager,
        relationships: RelationshipManager
    ) -> GiftResult? {
        // Remove item from inventory
        guard let slotIndex = inventory.inv.slots.firstIndex(where: { $0?.id == item.id }) else {
            print("Item not found in inventory.")
            return nil
        }
        inventory.inv.slots[slotIndex] = nil

        // Calculate XP
        let isPreferred = self.isPreferred(characters: character, item: item)
        let xpGained = isPreferred ? baseXP * preferredBonusMultiplier : baseXP
        
        // Get tier before adding XP
        let tierBefore = relationships.getRelationship(for: character.identity.name)?.currentTierIndex ?? 0
        
        let characterName = character.identity.name
        
        // Add XP
        relationships.addXP(for: characterName, amount: xpGained)

        // Check if tier changed
        let tierAfter = relationships.getRelationship(for: characterName)?.currentTierIndex ?? 0
        let didTierUp = tierAfter > tierBefore
        let newTier = didTierUp ? relationships.getTier(for: characterName) : nil

        return GiftResult(
            xpGained: xpGained,
            tierUp: didTierUp,
            newTier: newTier,
            characterName: characterName
        )
    }
    
    static func isPreferred(characters: GameCharacter, item: InventoryItem) -> Bool {
        return characters.gifts.preferences.contains(item.itemDef)
    }
}
