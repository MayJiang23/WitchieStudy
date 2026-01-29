//
//  LiveSessionManager.swift
//  WithieStudy
//
//
import Foundation
import Combine
import SwiftData

@Observable
class LiveSessionManager {
    private var cancellables = Set<AnyCancellable>()
    
    var modelContext: ModelContext
    var isActive: Bool = false
    var secondsRemain: Int = 1500
    var currentSession: ProductivitySession!
    
    var timer: SessionTimer = SessionTimer()
    var historyManager: SessionHistoryManager
    var sessionTypeManager: SessionTypeManager
    
    
    init(history: SessionHistoryManager, sessionTypes: SessionTypeManager, modelContext: ModelContext) {
        self.historyManager = history
        self.sessionTypeManager = sessionTypes
        self.modelContext = modelContext
        
        timer.$secondsRemain
            .receive(on: RunLoop.main)
            .assign(to: \.secondsRemain, on: self)
            .store(in: &cancellables)
        
        fetchLiveSession()
    }
    
    func editSession(type: SessionType, durationInSeconds: Int) {
        currentSession.set(startTime: nil, type: type, durationInSeconds: durationInSeconds)
        timer.setTimer(newTime: durationInSeconds)
        save()
    }
    
    func start() {
        currentSession.set(startTime: Date.now, type: nil, durationInSeconds: nil)
        isActive = true
        timer.resume()
    }
    
    func pauseTimer() {
        isActive = false
        timer.pause()
    }
    
    func resetTimer() {
        timer.setTimer(newTime: currentSession.durationInSeconds)
    }
    
    func finish() -> Void {
        pauseTimer()
        
        let actualTimeSpent = Double(currentSession.durationInSeconds - secondsRemain)
        resetTimer()
        
        if actualTimeSpent < 60 {
            return
        }
        
        historyManager.addSession(type: currentSession.type, duration: actualTimeSpent, dateCompleted: Date.now, notes: "A productivy time had passed...")
    }
    
    private func fetchLiveSession() {
        let descriptor = FetchDescriptor<ProductivitySession>()
        
        do {
            let sessions = try modelContext.fetch(descriptor)
            if let existingSession = sessions.first {
                currentSession = existingSession
                timer.setTimer(newTime: existingSession.durationInSeconds)
            } else {
                let newSession = ProductivitySession(startTime: Date.now, durationInSeconds: 1500, type: SessionType(title: "Work"))
                
                modelContext.insert(newSession)
                currentSession = newSession        }
        } catch {
            print("Fetch failed: \(error.localizedDescription)")
        }
    }
    
    private func save() {
        try? modelContext.save()
    }
    
    
}
