import SpriteKit

class AnimationSceneContainer: SKScene {
    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let character = CharacterModelNode(characterName: "mc")
        character.position = .zero
        addChild(character)
        
        
        
        let library = AnimationLibrary(animations: ["idle": Animation.idle], name: "default")

        character.setLibrary(library: library, name: "default")

        character.animate(animationName: "idle")
    }
}
