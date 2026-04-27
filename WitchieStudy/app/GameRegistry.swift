class GameRegistry {
    var data: [String: Registry]
    
    init() {
        self.data["items"] = ItemRegistry()
        self.data["characters"] = CharacterRegistry()
    }
    
    
}
