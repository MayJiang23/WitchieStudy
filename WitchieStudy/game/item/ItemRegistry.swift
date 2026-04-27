import Foundation

class ItemRegistry: Registry {
    private var items: [ItemDef] = []

    init() {
        loadItems()
    }

    func allItems() -> [ItemDef] {
        return self.items
    }

    subscript(id: String) -> ItemDef? {
        return self.items.first { $0.id == id }
    }
    
    subscript(ids: [String]) -> [ItemDef]? {
        return self.items.filter { ids.contains($0.id) }
    }

    private func loadItems() {
        if let loaded = AssetLoader.loadJson(filename: "data/items/index", as: [ItemDef].self) {
            self.items = loaded
            print(self.items)
        } else {
            print("Failed to load NPC data from npcs.json")
        }
    }
}
