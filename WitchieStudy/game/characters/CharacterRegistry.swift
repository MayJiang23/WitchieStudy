import Foundation

class CharacterRegistry {
    private var characters: [GameCharacter] = []

    init() {
        loadCharacters()
    }

    func allCharacters() -> [GameCharacter] {
        return characters
    }

    func getCharacter(named name: String) -> GameCharacter? {
        return characters.first { $0.name == name }
    }

    func getCharacter(byId id: UUID) -> GameCharacter? {
        return characters.first { $0.id == id }
    }


    private func loadCharacters() {
        if let loaded = AssetLoader.loadJson(filename: "data/characters/npcs", as: [GameCharacter].self) {
            self.characters = loaded
        } else {
            print("Failed to load NPC data from npcs.json")
        }
    }
}
