import SwiftUI
import SwiftData

struct TimerView: View {
    @Environment(\.modelContext) var modelContext
    @State private var manager: LiveSessionManager? // Back to Optional

    var body: some View {
        // We wrap the ENTIRE UI in this 'if let'
        Group {
            if let manager = manager {
                VStack(spacing: 40) {
                    Text(manager.currentSession.type.title)
                        .font(.headline)
                    
                    ZStack {
                        Circle().stroke(Color.gray.opacity(0.2), lineWidth: 20)
                        Circle()
                            .trim(from: 0, to: CGFloat(manager.secondsRemain) / 1500)
                            .stroke(Color.blue, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                            .rotationEffect(.degrees(-90))
                            .animation(.easeInOut, value: manager.secondsRemain)

                        Text(manager.timer.timeFormatted)
                            .font(.system(size: 60, weight: .bold, design: .monospaced))
                    }
                    .frame(width: 250, height: 250)

                    HStack(spacing: 30) {
                        if manager.isActive {
                            Button("Pause") { manager.pauseTimer() }
                        } else {
                            Button("Start") { manager.start() }
                        }
                        Button("Stop") { manager.finish() }
                            .tint(.red)
                    }
                }
            } else {
                // This shows for a split second while .onAppear runs
                ProgressView()
            }
        }
        .onAppear {
            if manager == nil {
                manager = LiveSessionManager(
                    history: SessionHistoryManager(modelContext: modelContext),
                    sessionTypes: SessionTypeManager(modelContext: modelContext),
                    modelContext: modelContext
                )
            }
        }
    }
}
