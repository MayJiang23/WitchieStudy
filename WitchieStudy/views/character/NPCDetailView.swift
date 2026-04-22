import SwiftUI

struct NPCDetailView: View {
    @Environment(AppState.self) var appState
    let character: GameCharacter

    @State private var showGiftSheet = false
    @State private var lastGiftResult: GiftResult?
    @State private var flavorText: String?
    @State private var portraitScale: CGFloat = 1.0

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ZStack {
                    Circle()
                        .fill(Color.secondary.opacity(0.15))
                        .frame(width: 120, height: 120)
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .foregroundColor(.secondary)
                }
                .scaleEffect(portraitScale)
                .onTapGesture {
                    let tierIndex = appState.relations.getRelationship(for: character.identity.name)?.currentTierIndex ?? 0
                    let lines = character.dialogueForTier(tierIndex)
                    if let line = lines.randomElement() {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                            portraitScale = 1.1
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                                portraitScale = 1.0
                            }
                        }
                        withAnimation(.easeInOut(duration: 0.3)) {
                            flavorText = line
                        }
                    }
                }

                // Flavor text bubble
                if let text = flavorText {
                    Text("\(text)")
                        .font(.subheadline.italic())
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(.systemGray))
                        )
                        .transition(.opacity.combined(with: .move(edge: .top)))
                        .padding(.horizontal)
                }

                Text(character.identity.name)
                    .font(.largeTitle.bold())

                Text(character.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                VStack(spacing: 10) {
                    if let tier = appState.relations.getTier(for: character.name) {
                        Text(tier.title)
                            .font(.title2.bold())
                            .foregroundColor(.blue)

                        Text(tier.description)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    } else {
                        Text("Stranger")
                            .font(.title2.bold())
                            .foregroundColor(.gray)
                    }

                    if let progress = appState.relations.getProgress(for: character.name) {
                        VStack(spacing: 4) {
                            ProgressView(value: Double(progress.current), total: Double(progress.nextThreshold))
                                .tint(.blue)
                            Text("\(progress.current) / \(progress.nextThreshold) XP")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                        .padding(.horizontal, 40)
                    }
                }

                let tierIndex = appState.relations.getRelationship(for: character.name)?.currentTierIndex ?? 0
                let dialogueLines = character.dialogueForTier(tierIndex)
                if !dialogueLines.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Dialogue")
                            .font(.headline)
                        ForEach(dialogueLines, id: \.self) { line in
                            HStack(alignment: .top) {
                                Text("💬")
                                Text(line)
                                    .font(.body)
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                    .padding()
                    .background(Color(.systemGray))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }

                Button(action: { showGiftSheet = true }) {
                    HStack {
                        Image(systemName: "gift.fill")
                        Text("Give a Gift")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(14)
                }
                .padding(.horizontal)

                if let result = lastGiftResult {
                    VStack(spacing: 4) {
                        Text("+\(result.xpGained) XP")
                            .font(.headline)
                            .foregroundColor(.green)
                        if result.tierUp, let newTier = result.newTier {
                            Text("Tier Up! Now: \(newTier.title)")
                                .font(.subheadline)
                                .foregroundColor(.blue)
                        }
                    }
                    .transition(.scale)
                }

                Spacer()
            }
            .padding(.vertical)
        }
        .sheet(isPresented: $showGiftSheet) {
            GiftSelectionSheet(character: character) { result in
                lastGiftResult = result
            }
        }
        .navigationTitle(character.identity.name)
        //.navigationBarTitleDisplayMode(.inline)
    }
}

struct GiftSelectionSheet: View {
    @Environment(AppState.self) var appState
    @Environment(\.dismiss) var dismiss

    let character: GameCharacter
    var onGift: (GiftResult) -> Void

    var body: some View {
        NavigationStack {
            VStack {
                Text("Select an item to gift to \(character.identity.name)")
                    .font(.headline)
                    .padding()

                let slots = appState.inventory.inv.slots
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 15) {
                    ForEach(0.<slots.count, id: \.self) { index in
                        if let item = slots[index] {
                            Button(action: {
                                if let result = GiftService.giftItem(
                                    item: item,
                                    to: character,
                                    inventory: appState.inventory,
                                    relationships: appState.relations
                                ) {
                                    onGift(result)
                                    dismiss()
                                }
                            }) {
                                VStack {
                                    Image(systemName: item.icon)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(.blue)
                                    Text(item.name)
                                        .font(.caption2)
                                }
                                .frame(width: 80, height: 80)
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding()

                Spacer()
            }
            .navigationTitle("Gift")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}
