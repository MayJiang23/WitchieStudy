import Foundation
import Combine
import SwiftData

@MainActor
@Observable
class SessionReportManager {
    var modelContext: ModelContext
    var report: SessionReport!
    
    init(modelContext: ModelContext, _ report: SessionReport!) {
        self.modelContext = modelContext
        self.fetchData()
    }
    
    
    //Should change to add or update event later on
    func addItem(item: InventoryItem, source: ItemSource) {
        report.itemsFound.append(item)
    }
    
    private func fetchData() {
        let descriptor = FetchDescriptor<SessionReport>()
        
        do {
            let report = try modelContext.fetch(descriptor)
            if let existingReport = report.first {
                self.report = existingReport
            }
        } catch {
            print("Fetch failed: \(error.localizedDescription)")
        }
    }
    
    private func save() {
        try? modelContext.save()
    }
    
    private func deleteAll() {
        do {
            try modelContext.delete(model: SessionReport.self)
        } catch {
        }
    }
}
