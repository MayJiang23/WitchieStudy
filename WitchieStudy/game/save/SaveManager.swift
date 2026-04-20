class SaveManager {
    static let shared = SaveManager()
    
    func save(entities: Array<SaveableEntity>) {
        var worldState: [String: AnyCodable] = [:]
        
        for entity in entities {
            worldState[entity.entityId] = AnyCodable(entity.captureSnapshot())
        }
        
        //let envelope = SaveEnvelope(worldState)
    }
}
