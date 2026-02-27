import SwiftUI

struct TimerDisplay: View {
    @Bindable var manager: LiveSessionManager
    
    @State private var showSessionEdit = false
    
    var body: some View {
        VStack(spacing: 3) {
            Text(manager.currentSession.type.title)
                .font(.headline)
            
            ZStack {
                Text(manager.timeFormatted)
                        .font(.system(size: 40, weight: .bold, design: .monospaced))
            }
            .frame(width: 130, height: 100)
            .onTapGesture {
                if !manager.currentSession.started {
                    showSessionEdit = true
                }
            }
            .sheet(isPresented: $showSessionEdit) {
                EditLiveSessionModal(manager: manager)
            }
        }
    }
}
