import SwiftData

class GameState {
    var modelContext: ModelContext
    
    var registries: GameRegistry
    var inventory: InventoryManager
    //var stats: StatManager
    var loot: LootManager
    var player: PlayerCharacterManager
    var relations: RelationshipManager
    var wardrobe: WardrobeManager
    
    
    init(_ modelContext: ModelContext) {
        self.modelContext = modelContext
        
        let registry = GameRegistry()
        self.registries = registry
        
        let newInventory = InventoryManager(modelContext: modelContext)
        self.inventory = newInventory
        
        self.loot = LootManager(inventory: newInventory)
        
        self.player = PlayerCharacterManager(modelContext: modelContext)
        
        self.relations = RelationshipManager(modelContext: modelContext, registry: registry.characters)
        self.wardrobe = WardrobeManager()
        self.wardrobe.playerManager = self.player
    }

    
}
