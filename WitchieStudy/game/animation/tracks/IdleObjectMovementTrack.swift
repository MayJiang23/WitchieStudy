import SpriteKit

struct IdleObjectMovementTrack: AnimationTrack {
    var targetNodeNames: [String]? = ["eyes"]
    
    var action: (AnimationContext) -> SKAction = { context in
        guard let node = context.targetNode else {
            return SKAction.wait(forDuration: 0)
        }
        
        let normal = SKAction.moveBy(x: 0, y: -4, duration: 0.4)
        let shortPause = SKAction.wait(forDuration: 0.15)
        let longPause = SKAction.wait(forDuration: 3)
        let reverse = SKAction.moveBy(x: 0, y: 4, duration: 0.4)
        
        let sequence = SKAction.sequence([normal, shortPause, normal, longPause, reverse, shortPause, reverse, shortPause])
        return SKAction.repeatForever(sequence)
    }
}
