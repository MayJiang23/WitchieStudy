class GameRegistry {
    var items: ItemRegistry
    var characters: CharacterRegistry
    
    init() {
        self.items = ItemRegistry()
        self.characters = CharacterRegistry()
    }
}
