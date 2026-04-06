import Foundation
import SpriteKit

class CharacterLoader {
    static func loadModel(of modelName: String) -> [String: [String: Any]] {
        let path = "data/models/\(modelName)/init"
        guard let config = AssetLoader.loadJson(filename: path, as: [String: VisualComponent].self) else {
                print("Failed to load config for \(modelName)")
                return [:]
        }
        
        var dict: [String: [String: Any]] = [:]
        
        for (partName, component) in config {
            let frames = FrameStorage.shared.get(part: partName, key: component.name)
            dict[partName] = [
                "frames": frames ?? [],
                "com": component
            ]
        }
        
        return dict
    }
}
