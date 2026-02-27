import SpriteKit

class CharacterModelNode: SKNode {
    private var componentNodes: [String: ModelComponentNode] = [:]
    private var animationLibraries: [String: AnimationLibrary] = [:]
    private var stateMachine: Any?
    
    init(characterName: String) {
        super.init()
        let initConfig = CharacterLoader.loadModel(of: characterName)
        //print(initConfig)
        for (name, value) in initConfig {
            guard
                let frame = value["frames"] as? VisualFrames,
                let visualCom = value["com"] as? VisualComponent,
                let firstFrame = frame.textures.first
            else {
                print("Exit at init")
                continue }
            let component = ModelComponentNode(visual: visualCom, texture: firstFrame)
            component.frameHub.set(action: frame.actionName, direction: frame.dirName, textures: frame)
            addChild(component)
            componentNodes[name] = component
        }
    }
    func animate(animationName: String) {
        guard let library = animationLibraries["default"],
              let animation = library.get(key: animationName) else {
            //print("exiting here")
            return
        }

        for track in animation.tracks {
            let targets: [ModelComponentNode]
            
            if let targetedNames = track.targetNodeNames {
                targets = targetedNames.compactMap { componentNodes[$0] }
            } else {
                targets = Array(componentNodes.values)
            }
            for targetNode in targets {
                let visualFrame = targetNode.frameHub
                //print(visualFrame)
                let frames = visualFrame.get(action:"idle", direction:"f")
                
                let context = AnimationContext(frames: frames?.textures, targetNode: targetNode)
                //print(context)
                let action = track.action(context)
                //print(action)
                targetNode.run(action, withKey: animationName)
            }
        }
    }
    
    func setLibrary(library: AnimationLibrary, name: String) {
        animationLibraries[name] = library
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
