import SwiftUI

struct NPCListView: View {
    @Environment(AppState.self) var appState

    var body: some View {
        let characters = appState.characterRegistry.allCharacters()

        VStack(spacing: 12) {
            ForEach(characters) { character in
                NavigationLink(destination: NPCDetailView(character: character)) {
                    NPCRow(character: character, relationships: appState.relations)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal)
    }
}

struct NPCRow: View {
    let character: GameCharacter
    let relationships: RelationshipManager

    var body: some View {
        HStack(spacing: 15) {
            // Portrait placeholder
            ZStack {
                Circle()
                    .fill(Color.secondary.opacity(0.2))
                    .frame(width: 50, height: 50)
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.secondary)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(character.identity.name)
                    .font(.headline)

                if let tier = relationships.getTier(for: character.name) {
                    Text(tier.title)
                        .font(.caption)
                        .foregroundColor(.secondary)
                } else {
                    Text("Stranger")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                // XP progress bar
                if let progress = relationships.getProgress(for: character.name) {
                    ProgressView(value: Double(progress.current), total: Double(progress.nextThreshold))
                        .tint(.blue)
                }
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemGray))
        .cornerRadius(12)
        .shadow(radius: 1)
    }
}
