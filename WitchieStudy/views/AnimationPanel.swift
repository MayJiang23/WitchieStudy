import SwiftUI
import SpriteKit

struct AnimationPanel: View {
    var scene: SKScene {
        let scene = AnimationSceneContainer()
        scene.size = CGSize(width: 512, height: 576)
        scene.scaleMode = .aspectFit
        scene.backgroundColor = .clear
        return scene
    }

    var body: some View {
        SpriteView(scene: scene, options: [.allowsTransparency])
            .frame(width: 320, height: 360)
    }
}
