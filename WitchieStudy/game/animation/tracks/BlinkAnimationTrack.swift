import SpriteKit

struct BlinkAnimationTrack: AnimationTrack {
    var targetNodeNames: [String]? = ["eyes"]
    
    var action: (AnimationContext) -> SKAction = { context in
        guard let originalFrames = context.frames, !originalFrames.isEmpty else {
            return SKAction.wait(forDuration: 0)
        }
        
        let normal = SKAction.animate(with: originalFrames, timePerFrame: 0.1)
        let reverse = SKAction.animate(with: originalFrames.reversed(), timePerFrame: 0.15)
        let lastPause = SKAction.wait(forDuration: 5)
        
        let actionGroup = SKAction.sequence([normal, reverse, lastPause])
        
        return SKAction.repeatForever(actionGroup)
    }
}
