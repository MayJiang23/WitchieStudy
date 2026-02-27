import Foundation
import SpriteKit

class FrameStorage {
    static let shared = FrameStorage()
    
    private var cache: [String: [String:VisualFrames]] = [:]

    func get(part: String, key: String) -> VisualFrames? {
        if let textures = cache[part]?[key] {
            return textures
        }
        load(part: part, key: key)
        return cache[part]?[key]
    }
    
    func load(part: String, key: String) {
        //print("Loading: ", part, "with key: ", key)
        let atlas = SKTextureAtlas(named: part)
        //print("atlas: ", atlas)
        
        let allNames = atlas.textureNames
        
        
        let grouped = Dictionary(grouping: allNames) { name -> String in
            let components = name.components(separatedBy: "_")
            if components.count > 1 {
                return components.dropLast().joined(separator: "_")
            }
            return name
        }
        
        
        if cache[part] == nil { cache[part] = [:] }

        for (baseName, frameNames) in grouped {
            let sortedFrameNames = frameNames.sorted()
            let textures = sortedFrameNames.map { atlas.textureNamed($0) }
            let visualFramesObject = VisualFrames(name: baseName, actionName: baseName.components(separatedBy: "_")[1], dirName: baseName.components(separatedBy: "_")[2], textures: textures)
            cache[part]?[key] = visualFramesObject
        }
    }
}
