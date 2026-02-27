import SpriteKit

class AnimationSceneContainer: SKScene {
    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let character = CharacterModelNode(characterName: "mc")
        character.position = .zero
        addChild(character)
        
        let idleTrack = IdleAnimationTrack()
        let blinkTrack = BlinkAnimationTrack()
        let idleMovementTrack = IdleObjectMovementTrack()
        let animation = Animation(tracks: [idleTrack, blinkTrack, idleMovementTrack])
        
        let library = AnimationLibrary(animations: ["idle": animation], name: "default")

        character.setLibrary(library: library, name: "default")

        character.animate(animationName: "idle")
    }
}
