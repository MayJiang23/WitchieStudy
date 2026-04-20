import SwiftData

@Model
class GameCharacter: SaveableEntity {
    @Attribute(.unique) var entityId: String
    
    @Relationship(deleteRule: .cascade)
    var modules: Array<Module>
    
    init(entityId: String, modules: Array<Module>) {
        self.entityId = entityId
        self.modules = modules
    }
    
    func captureSnapshot() -> AnyCodable {
        var dict: [String: AnyCodable] = [:]
        
        for module in modules {
            dict[module.moduleKey] = module.toSaveState()
        }
        
        let state = CharacterSaveState(id: self.entityId, moduleData: dict)
        return AnyCodable(state)
    }
}
