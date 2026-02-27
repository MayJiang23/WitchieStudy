import Foundation
import SpriteKit

struct AnimationLibrary {
    var animations: [String:Animation]
    var name: String
    
    func get(key: String) -> Animation? {
        return animations[key] ?? nil
    }
}
