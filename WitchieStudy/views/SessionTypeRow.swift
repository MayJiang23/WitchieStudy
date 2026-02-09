import SwiftUI

// MARK: - Sub-view to simplify the main body
struct SessionTypeRow: View {
    let type: SessionType // Replace with your actual Type name if different
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(type.title)
                    .foregroundStyle(.primary)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.blue)
                }
            }
        }
    }
}
