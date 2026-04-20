import SwiftData
import Foundation

class PlayerCharacterInitializer {
    static func initialize(container: ModelContainer) {
        let context = container.mainContext
        let descriptor = FetchDescriptor<PlayerCharacter>()

        if let count = try? context.fetchCount(descriptor), count == 0 {
            let player = PlayerCharacter(name: "Apprentice", currency: 0)
            context.insert(player)
            do {
                try context.save()
            } catch {
                print("Failed to save initial PlayerCharacter: \(error.localizedDescription)")
            }
        }
    }
}
