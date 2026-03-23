import SwiftUI
import UniformTypeIdentifiers

struct InventoryDropDelegate: DropDelegate {
    let destinationIndex: Int
    var manager: InventoryManager

    func performDrop(info: DropInfo) -> Bool {
        guard let itemProvider = info.itemProviders(for: [.text]).first else { return false }

        itemProvider.loadObject(ofClass: NSString.self) { (indexString, error) in
            if let indexString = indexString as? String, let sourceIndex = Int(indexString) {
                Task { @MainActor in
                    manager.moveItem(from: sourceIndex, to: destinationIndex)
                }
            }
        }
        return true
    }
}
