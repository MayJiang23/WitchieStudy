//
//  SessionHistoryView.swift
//  WithieStudy
//
//
import SwiftUI
import SwiftData


struct SessionHistoryView: View {
    @Query var allSessions: [PastSession]
    
    var sessionTotals: [(type: String, total: Double)] {
        let grouped = Dictionary(grouping: allSessions, by: { $0.type.title })
        
        return grouped.map { (key, value) in
            let total = value.reduce(0) {
                $0 + $1.duration }
            return (type: key, total: total)
            
        }.sorted { $0.type < $1.type }
    }
    
    var body: some View {
        HStack {
            List {
                Section("Summary by Type") {
                    ForEach(sessionTotals, id: \.type) { summary in
                        HStack {
                            Text(summary.type)
                                .font(.headline)
                            Spacer()
                            Text("\(Int(summary.total) / 60) mins")
                                .fontWeight(.bold)
                        }
                    }
                }
                
                Section("Recent Sessions") {
                    ForEach(allSessions) { session in
                        HStack {
                            Text(session.type.title)
                            Spacer()
                            Text("\(Int(session.duration) / 60) mins")
                                .foregroundColor(.secondary)
                        }
                        
                    }
                }
            }
            
        }
    }
}
