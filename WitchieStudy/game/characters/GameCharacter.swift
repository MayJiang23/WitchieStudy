import SwiftData
import Foundation

@Model
class GameCharacter: Codable, SaveableEntity {
    @Attribute(.unique) var entityId: String
    
    //@Relationship(deleteRule: .nullify)
    //var modules: Array<Module>
    
    var id: UUID

    // - Modules

    var identity: IdentityModule
    var dialogue: DialogueModule
    var gifts: GiftModule
    var relationProfile: RelationProfile


    //var name: String { identity.name }
    //var description: String { identity.desc }
    //var portraitImageName: String { identity.portraitImageName }
    //var giftPreferences: [String] { gifts.preferences }

    
    init(
            id: UUID = UUID(),
            entityId: String,
            identity: IdentityModule,
            dialogue: DialogueModule,
            gifts: GiftModule,
            relationProfile: RelationProfile
        ) {
            self.id = id
            self.entityId = entityId
            self.identity = identity
            self.dialogue = dialogue
            self.gifts = gifts
            self.relationProfile = relationProfile
        }
    

    func dialogueForTier(_ tierIndex: Int) -> [String] {
        return dialogue.linesForTier(tierIndex)
    }

    func captureSnapshot() -> AnyCodable {
        return AnyCodable(CharacterSaveState(id: id.uuidString, moduleData: [:]))
    }


    private enum CodingKeys: String, CodingKey {
        case entityId
        case id
        case name, description, portraitImageName
        case giftPreferences
        case dialogue
        case relationProfile
    }

    required init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        id = try c.decode(UUID.self, forKey: .id)
        relationProfile = try c.decode(RelationProfile.self, forKey: .relationProfile)

        entityId = try c.decode(String.self, forKey: .entityId)
        
        identity = IdentityModule(
            name: try c.decode(String.self, forKey: .name),
            description: try c.decode(String.self, forKey: .description),
            portraitImageName: try c.decodeIfPresent(String.self, forKey: .portraitImageName) ?? ""
        )

        dialogue = DialogueModule(
            lines: try c.decodeIfPresent([String: [String]].self, forKey: .dialogue) ?? [:]
        )

        gifts = GiftModule(
            preferences: try c.decodeIfPresent([String].self, forKey: .giftPreferences) ?? []
        )
    }

    func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)
        try c.encode(id, forKey: .id)
        try c.encode(identity.name, forKey: .name)
        try c.encode(identity.desc, forKey: .description)
        try c.encode(identity.portraitImageName, forKey: .portraitImageName)
        try c.encode(gifts.preferences, forKey: .giftPreferences)
        try c.encode(dialogue.lines, forKey: .dialogue)
        try c.encode(relationProfile, forKey: .relationProfile)
    }
    
    /**
    func captureSnapshot() -> AnyCodable {
        var dict: [String: AnyCodable] = [:]
        
        for module in modules {
            dict[module.moduleKey] = module.toSaveState()
        }
        
        let state = CharacterSaveState(id: self.entityId, moduleData: dict)
        return AnyCodable(state)
    }
    */
}
