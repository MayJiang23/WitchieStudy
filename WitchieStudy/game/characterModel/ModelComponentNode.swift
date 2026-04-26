import Foundation
import SpriteKit

class ModelComponentNode: SKSpriteNode {
    var visual: VisualComponent
    var frameHub: VisualFrameHub = VisualFrameHub()
    
    init(visual: VisualComponent, texture: SKTexture) {
        self.visual = visual
        super.init(texture: texture, color: .white, size: texture.size())
        self.zPosition = CGFloat(visual.z)
    }
    
    func update() {}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
