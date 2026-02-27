//
//  WithieStudyApp.swift
//  WithieStudy
//
//  Created by Pitten Pant on 1/26/26.
//

import SwiftUI
import SwiftData

@main
struct WithieStudyApp: App  {
    let container: ModelContainer
    init() {
        do {
            container = try ModelContainer(for: ProductivitySession.self)
            bootstrapSession()
        } catch {
            fatalError("Failed to initialize SwiftData")
        }
    }
    
    private func bootstrapSession() {
        let context = container.mainContext
        let descriptor = FetchDescriptor<ProductivitySession>()
        
        if let count = try? context.fetchCount(descriptor), count == 0 {
            let initialSession = ProductivitySession(
                startTime: Date.now,
                durationInSeconds: 1500,
                type: SessionType(title: "Work"),
                secondsRemain: 1500
            )
            context.insert(initialSession)
            try? context.save()
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [PastSession.self, SessionType.self])
    }
}
