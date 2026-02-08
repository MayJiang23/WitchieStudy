import SwiftUI

struct EditLiveSessionModal: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button("Close Me") {
            dismiss()
        }
    }
}
