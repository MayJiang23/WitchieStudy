/**
    Represents gift preferences for a single entity.
 */

struct GiftPreference {
    private(set) var definitions: [ItemDef]?
    
    mutating func resolve(itemId: [String], using registry: ItemRegistry) {
        self.definitions = registry[itemId]
    }
}
