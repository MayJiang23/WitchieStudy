import SpriteKit

class AnimationSceneContainer: SKScene {
    override func didMove(to view: SKView) {
        let atlas = SKTextureAtlas(named: "CharacterAnimation")
        let frames = [atlas.textureNamed("frame1"), atlas.textureNamed("frame2")]
        
        let character = SKSpriteNode(texture: frames[0])
        character.position = CGPoint(x: frame.midX, y: frame.midY)
        character.size = self.size
        addChild(character)
        
        let animation = SKAction.animate(with: frames, timePerFrame: 0.5)
        character.run(SKAction.repeatForever(animation))
    }
}
