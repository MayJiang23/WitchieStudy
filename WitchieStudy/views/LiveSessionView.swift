import SwiftUI
import SwiftData

struct LiveSessionView: View {
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.modelContext) var modelContext
    @State private var manager: LiveSessionManager? 

    var body: some View {
        Group {
            if let manager {
                TimerDisplay(manager: manager)
                    
                HStack(spacing: 30) {
                    if manager.isActive {
                        Button("Pause") { manager.pause() }
                    } else if manager.currentSession.started {
                        Button("Resume") {
                            manager.resume()
                        }
                    } else {
                        Button("Start") { manager.start() }
                    }
                    Button("Stop") { manager.finish() }
                    .tint(.red)
                }
            } else {
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
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .background || newPhase == .inactive {
                manager?.handleAppExit()
            }
        }
    }
}
