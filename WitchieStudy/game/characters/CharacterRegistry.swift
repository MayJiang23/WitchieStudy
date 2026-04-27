import Foundation

class CharacterRegistry: Registry {
    private var characters: [GameCharacter] = []

    init() {
        loadCharacters()
    }

    func allCharacters() -> [GameCharacter] {
        return self.characters
    }

    subscript(name: String) -> GameCharacter? {
        return self.characters.first { $0.name == name }
    }

    subscript(id: UUID) -> GameCharacter? {
        return self.characters.first { $0.id == id }
    }

    private func loadCharacters() {
        if let loaded = AssetLoader.loadJson(filename: "data/characters/npcs", as: [GameCharacter].self) {
            self.characters = loaded
            print(self.characters)
        } else {
            print("Failed to load NPC data from npcs.json")
        }
    }
}
