import Foundation
import SwiftData

@Model
class RelationshipState: Identifiable {
    var id: UUID
    var characterName: String
    var currentXP: Int
    var currentTierIndex: Int

    init(characterName: String, currentXP: Int = 0, currentTierIndex: Int = 0) {
        self.id = UUID()
        self.characterName = characterName
        self.currentXP = currentXP
        self.currentTierIndex = currentTierIndex
    }
}
