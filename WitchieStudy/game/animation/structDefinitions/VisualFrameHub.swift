import SpriteKit

struct VisualFrameHub {
    var frames: [String: [String: VisualFrames]] = [:]
    
    func get(action: String, direction: String) -> VisualFrames? {
        return frames[action]?[direction] ?? nil
    }
    
    mutating func set(action: String, direction: String, textures: VisualFrames) {
        if frames[action] == nil {
            frames[action] = [:]
        }
        frames[action]?[direction] = textures
    }
}
