import Foundation
import SwiftData

@Observable
class PlayerCharacterManager {
    var player: PlayerCharacter

    init() {
        fetchPlayer()
    }

    private func fetchPlayer() {
        let descriptor = FetchDescriptor<PlayerCharacter>()
        Task {
            if let existing = await DataCoordinator.shared.get(descriptor)?.first {
                self.player = existing
            } else {
                self.player = await PlayerCharacterHelper.createDefault()
            }
            
        }
    }
}

final actor PlayerCharacterHelper {
    static func createDefault() async -> PlayerCharacter {
        let descriptor = FetchDescriptor<SaveableEntity>(predicate: #Predicate{ $0.blueprintId == "player" })
        let playerCore = await DataCoordinator.shared.getOrCreate(descriptor) { SaveableEntity.createDefault("player") }
        return PlayerCharacter(core: playerCore.first!)
    }
}
