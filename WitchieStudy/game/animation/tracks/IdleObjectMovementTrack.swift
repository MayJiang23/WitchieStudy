import SpriteKit

struct IdleObjectMovementTrack: AnimationTrack {
    var targetNodeNames: [String]? = ["eyes"]
    
    var action: (AnimationContext) -> SKAction = { context in
        guard let node = context.targetNode else {
            return SKAction.wait(forDuration: 0)
        }
        
        let normal = SKAction.moveBy(x: 0, y: -2, duration: 0.45)
        let normal2 = SKAction.moveBy(x: 0, y: -3, duration: 0.45)
        let shortPause = SKAction.wait(forDuration: 0.05)
        let longPause = SKAction.wait(forDuration: 1)
        let reverse = SKAction.moveBy(x: 0, y: 2, duration: 0.4)
        let reverse2 = SKAction.moveBy(x: 0, y: 3, duration: 0.4)
        
        let sequence = SKAction.sequence([normal2, normal, normal, shortPause, reverse2, reverse, reverse, longPause])
        return SKAction.repeatForever(sequence)
    }
}
