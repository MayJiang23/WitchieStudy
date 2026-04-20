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
        let isPreferred = character.giftPreferences.contains(item.name)
        let xpGained = isPreferred ? baseXP * preferredBonusMultiplier : baseXP

        // Get tier before adding XP
        let tierBefore = relationships.getRelationship(for: character.name)?.currentTierIndex ?? 0

        // Add XP
        relationships.addXP(for: character.name, amount: xpGained)

        // Check if tier changed
        let tierAfter = relationships.getRelationship(for: character.name)?.currentTierIndex ?? 0
        let didTierUp = tierAfter > tierBefore
        let newTier = didTierUp ? relationships.getTier(for: character.name) : nil

        return GiftResult(
            xpGained: xpGained,
            tierUp: didTierUp,
            newTier: newTier,
            characterName: character.name
        )
    }
}
