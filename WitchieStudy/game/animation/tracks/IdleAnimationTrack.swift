import SpriteKit

struct IdleAnimationTrack: AnimationTrack {
    var targetNodeNames: [String]? = ["backhair", "fronthair", "head"]
    
    var action: (AnimationContext) -> SKAction = { context in
        guard let originalFrames = context.frames, !originalFrames.isEmpty else {
            return SKAction.wait(forDuration: 0)
        }
        let normal = SKAction.animate(with: originalFrames, timePerFrame: 0.45)
        let slightPause = SKAction.wait(forDuration: 0.05)
        let reverse = SKAction.animate(with: originalFrames.reversed(), timePerFrame: 0.4)
        let lastPause = SKAction.wait(forDuration: 0.1)
        return SKAction.repeatForever(SKAction.sequence([normal, slightPause, reverse, lastPause]))
    }
}
