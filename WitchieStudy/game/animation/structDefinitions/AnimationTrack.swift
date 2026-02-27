import Foundation
import SpriteKit

protocol AnimationTrack {
    var targetNodeNames: [String]? { get }
    var action: (AnimationContext) -> SKAction { get }
}
