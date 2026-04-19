import SwiftUI

struct SessionReportView: View {
    let report: SessionReport
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color(hex: "#1A1A1A").ignoresSafeArea()
            
            VStack(spacing: 20) {
                VStack {
                    Image(systemName: "dog.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.black)
                        .background(Circle().fill(Color.purple.opacity(0.3)))
                    
                    Text("Session Concluded")
                        .font(.custom("Georgia", size: 28))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .padding(.top, 40)

                VStack(spacing: 15) {
                    ReportStatRow(label: "Time Studied", value: "\(report.durationMinutes)m", color: .blue)
                    ReportStatRow(label: "Stat Changed", value: "+\(report.statChange)", color: .purple)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 15).fill(Color.white.opacity(0.05)))
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(report.characterName)
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.purple)
                    
                    Text("\"\(report.characterQuote)\"")
                        .font(.italic(.body)())
                        .foregroundColor(.gray)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.purple.opacity(0.5)))

                if !report.itemsFound.isEmpty {
                    HStack {
                        ForEach(report.itemsFound, id: \.self) { item in
                            VStack {
                                Image(systemName: "briefcase.fill")
                                    .foregroundColor(.yellow)
                                Text(item.name).font(.caption2).foregroundColor(.white)
                            }
                            .frame(width: 60)
                        }
                    }
                }

                Spacer()

                Button(action: { dismiss() }) {
                    Text("Return to Academy")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.yellow)
                        .cornerRadius(12)
                }
            }
            .padding(25)
        }
    }
}

struct ReportStatRow: View {
    let label: String
    let value: String
    let color: Color
    
    var body: some View {
        HStack {
            Text(label).foregroundColor(.gray)
            Spacer()
            Text(value).fontWeight(.bold).foregroundColor(color)
        }
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}

struct SessionReport_Previews: PreviewProvider {
    static var previews: some View {
        SessionReportView(report: SessionReport(
            activityName: "Human History",
            durationMinutes: 45,
            statChange: 10,
            characterName: "Jibril",
            characterQuote: "Placeholder text.",
            itemsFound: [InventoryItem(id: UUID(), name: "Ink Pot", icon: "ink.fill")]
        ))
    }
}

