import SpriteKit


extension Animation {
    static var idle: Animation {
        let idleTrack = IdleAnimationTrack()
        let blinkTrack = BlinkAnimationTrack()
        let idleMovementTrack = IdleObjectMovementTrack()
        let new_tracks: [AnimationTrack] = [idleTrack, blinkTrack, idleMovementTrack]
        return Animation(tracks: new_tracks)
    }
}

struct IdleAnimationTrack: AnimationTrack {
    var targetNodeNames: [String]? = ["backhair", "fronthair", "head", "upper", "backhand"]
    
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

struct IdleObjectMovementTrack: AnimationTrack {
    var targetNodeNames: [String]? = ["eyes"]
    
    var action: (AnimationContext) -> SKAction = { context in
        guard let node = context.targetNode else {
            return SKAction.wait(forDuration: 0)
        }
        
        let moveDown = SKAction.moveBy(x: 0, y: -6, duration: 0.9)
        let pauseMid = SKAction.wait(forDuration: 0.5)
        let moveUp = SKAction.moveBy(x: 0, y: 6, duration: 0.85)
        let pauseEnd = SKAction.wait(forDuration: 0.5)
        let sequence = SKAction.sequence([moveDown, pauseMid, moveUp, pauseEnd])
        return SKAction.repeatForever(sequence)
    }
}


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

