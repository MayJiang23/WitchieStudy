import Foundation
import SwiftData

@Observable
class RelationshipManager {
    var modelContext: ModelContext
    var registry: CharacterRegistry

    init(modelContext: ModelContext, registry: CharacterRegistry) {
        self.modelContext = modelContext
        self.registry = registry
    }

    func addXP(for characterName: String, amount: Int) {
        let state = getOrCreateRelationship(for: characterName)
        state.currentXP += amount

        // Check for tier promotion
        if let character = registry.getCharacter(named: characterName) {
            let tiers = character.relationProfile.tiers
            while state.currentTierIndex < tiers.count - 1
                    && state.currentXP >= tiers[state.currentTierIndex + 1].threshold {
                state.currentTierIndex += 1
            }
        }

        save()
    }

    func getRelationship(for characterName: String) -> RelationshipState? {
        let descriptor = FetchDescriptor<RelationshipState>(
            predicate: #Predicate { $0.characterName == characterName }
        )
        return try? modelContext.fetch(descriptor).first
    }

    func getTier(for characterName: String) -> RelationTier? {
        guard let state = getRelationship(for: characterName),
              let character = registry.getCharacter(named: characterName) else {
            return nil
        }
        let tiers = character.relationProfile.tiers
        guard state.currentTierIndex < tiers.count else { return nil }
        return tiers[state.currentTierIndex]
    }

    func getProgress(for characterName: String) -> (current: Int, nextThreshold: Int)? {
        guard let state = getRelationship(for: characterName),
              let character = registry.getCharacter(named: characterName) else {
            return nil
        }
        let tiers = character.relationProfile.tiers
        let nextIndex = state.currentTierIndex + 1
        let nextThreshold = nextIndex < tiers.count ? tiers[nextIndex].threshold : tiers.last?.threshold ?? 0
        return (state.currentXP, nextThreshold)
    }


    private func getOrCreateRelationship(for characterName: String) -> RelationshipState {
        if let existing = getRelationship(for: characterName) {
            return existing
        }
        let newState = RelationshipState(characterName: characterName)
        modelContext.insert(newState)
        save()
        return newState
    }

    private func save() {
        do {
            try modelContext.save()
        } catch {
            print("RelationshipManager save failed: \(error.localizedDescription)")
        }
    }
}
