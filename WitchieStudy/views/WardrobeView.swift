import SwiftUI

struct WardrobeView: View {
    @State private var manager = WardrobeManager()
    @State private var selectedCategory: WardrobeCategory = .tops
    
    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.secondary.opacity(0.2))
                    .frame(height: 300)
                
                Text("Character Sprite Preview")
                    .foregroundColor(.gray)
                
                // Logic for layering sprites would go here
            }

            CategoryPicker()
        }
    }
}

struct WardrobeItemScrollView: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 15) {
                //ForEach(manager.availableItems.filter { $0.category == selectedCategory }) { item in
                //    ItemCard(item: item, isEquipped: manager.equippedItems[item.category] == item)
                //        .onTapGesture {
                //            manager.equip(item)
                //        }
                //}
            }
            .padding()
        }
    }
}

struct StatBadge: View {
    let label: String
    let value: Int
    let color: Color
    
    var body: some View {
        VStack {
            Text(label).font(.caption).bold()
            Text("\(value > 0 ? "+" : "")\(value)")
                .font(.title2)
                .foregroundColor(color)
        }
        .frame(maxWidth: .infinity)
        .padding(8)
        .background(color.opacity(0.1))
        .cornerRadius(10)
    }
}

struct CategoryPicker: View {
    @State private var selectedCategory: WardrobeCategory = .tops

    var body: some View {
        Picker("Category", selection: $selectedCategory) {
            ForEach(WardrobeCategory.allCases, id: \.self) { cat in
                Text(cat.rawValue).tag(cat)
            }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
    }
}

struct ItemCard: View {
    let item: ClothingItem
    let isEquipped: Bool
    
    var body: some View {
        VStack {
            Image(systemName: "tshirt.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            
            Text(item.name).font(.footnote)
        }
        .frame(width: 100, height: 100)
        .background(isEquipped ? Color.blue.opacity(0.2) : Color.gray.opacity(0.1))
        .border(isEquipped ? Color.blue : Color.clear, width: 2)
        .cornerRadius(10)
    }
}
