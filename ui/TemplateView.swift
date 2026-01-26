import SwiftUI
import SwiftData

struct TimerView: View {
    @StateObject var manager = LiveSessionManager(
        history: SessionHistoryManager(),
        sessionTypes: SessionTypeManager()
    )
    
    @State private var showingEditModal = false

    var body: some View {
        VStack(spacing: 40) {
            Text(manager.currentType.title)
                .font(.headline)
                .foregroundColor(.secondary)

            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), lineWidth: 20)
                
                Circle()
                    .trim(from: 0, to: CGFloat(manager.secondsRemain) / 1500)
                    .stroke(Color.blue, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut, value: manager.secondsRemain)

                Text(manager.timeFormatted)
                    .font(.system(size: 60, weight: .bold, design: .monospaced))
            }
            .frame(width: 250, height: 250)

            HStack(spacing: 30) {
                if manager.isActive {
                    Button("Pause") { manager.pauseTimer() }
                        .buttonStyle(.bordered)
                } else {
                    Button("Start") { manager.start() }
                        .buttonStyle(.borderedProminent)
                }
                
                Button("Stop") { manager.finish() }
                    .buttonStyle(.bordered)
                    .tint(.red)
            }

            Spacer()

            // 4. Trigger for the Modal
            Button("Edit Session") {
                showingEditModal = true
            }
        }
        .padding()
        //.sheet(isPresented: $showingEditModal) {
          //  EditSessionView(manager: manager)
        //}
    }
}

