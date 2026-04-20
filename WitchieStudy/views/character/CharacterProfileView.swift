import SwiftUI

struct CharacterProfileView: View {
    @Environment(AppState.self) var appState

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.secondary.opacity(0.15))
                        .frame(height: 280)

                    AnimationPanel()
                }
                .padding(.horizontal)

                VStack(spacing: 8) {
                    Text(appState.player.player.name)
                        .font(.title.bold())

                    HStack {
                        Image(systemName: "bitcoinsign.circle.fill")
                            .foregroundColor(.yellow)
                        Text("\(appState.player.player.currency)")
                            .font(.title3.bold())
                    }
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("Stats")
                        .font(.headline)
                        .padding(.horizontal)

                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                        ForEach(StatType.allCases) { stat in
                            StatBadge(
                                label: stat.rawValue,
                                value: appState.player.getStatValue(stat),
                                color: colorForStat(stat)
                            )
                        }
                    }
                    .padding(.horizontal)
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("Relationships")
                        .font(.headline)
                        .padding(.horizontal)

                    NPCListView()
                }
            }
            .padding(.vertical)
        }
    }

    private func colorForStat(_ stat: StatType) -> Color {
        switch stat {
        case .int: return .purple
        case .cha: return .pink
        case .wis: return .blue
        case .con: return .orange
        case .str: return .red
        case .dex: return .green
        }
    }
}
