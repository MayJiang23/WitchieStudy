import SwiftUI
import SwiftData

struct MainView: View {
    @State private var currentTab: String = "Timer"

    var body: some View {
        VStack() {
            Group {
                if currentTab == "Inventory" {
                    InventoryView()
                } else if currentTab == "History"{
                    SessionHistoryView()
                } else if currentTab == "Timer" {
                    TimerView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            HStack(spacing: 50) {
                Button(action: { currentTab = "Inventory" }) {
                    VStack {
                        Image(systemName: "bag")
                        Text("Inventory")
                    }
                }
                .foregroundColor(currentTab == "Inventory" ? .blue : .gray)
                
                Button(action: { currentTab = "Timer" }) {
                    VStack {
                        Image(systemName: "car")
                        Text("Timer")
                    }
                }
                .foregroundColor(currentTab == "Timer" ? .red : .gray)
                
                Button(action: { currentTab = "History" }) {
                    VStack {
                        Image(systemName: "clock")
                        Text("History")
                    }
                }
                .foregroundColor(currentTab == "History" ? .red : .gray)
            }
            .padding()
            .background(.ultraThinMaterial) // Gives that nice blurred glass look
            .cornerRadius(20)
            .padding(.bottom, 10)
        }
    }
}
