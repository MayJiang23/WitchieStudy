import Foundation
import SpriteKit

struct Animation {
    var tracks: [AnimationTrack]
    
    func build(with context: AnimationContext) -> [SKAction] {
        let generatedActions = tracks.map { $0.action(context) }
        return generatedActions
    }
}
