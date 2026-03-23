import SwiftUI
import UniformTypeIdentifiers


struct InventoryView: View {
    @Environment(AppState.self) var appState

    let columns = [GridItem(.adaptive(minimum: 80))]

    var body: some View {
        let manager = appState.inventory
        VStack {
            Text("Inventory")
                .font(.largeTitle.bold())
                .padding()

            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(0..<manager.inv.slots.count, id: \.self) { index in
                    InventorySlot(item: manager.inv.slots[index], index: index)
                        .onDrag {
                            NSItemProvider(object: String(index) as NSString)
                        }
                        .onDrop(of: [.text], delegate: InventoryDropDelegate(destinationIndex: index, manager: manager))
                }
            }
            .padding()
        }
        .background(Color(.white))
    }
}

struct InventorySlot: View {
    let item: InventoryItem?
    let index: Int

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .frame(width: 80, height: 80)
                .shadow(radius: 2)

            if let item = item {
                Image(systemName: item.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.blue)
            }
        }
    }
}
