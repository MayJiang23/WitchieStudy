//
//  LiveSessionManager.swift
//  WithieStudy
//
//
import Foundation
import Combine

@Observable
class LiveSessionManager {
    private var cancellables = Set<AnyCancellable>()
    
    var isActive: Bool = false
    var secondsRemain: Int = 1500
    var currentSession: ProductivitySession = ProductivitySession(startTime: Date.now, durationInSeconds: 1500, type: SessionType(title: "Work"))
    var timer: SessionTimer = SessionTimer()
    var historyManager: SessionHistoryManager
    var sessionTypeManager: SessionTypeManager
    
    
    
    init(history: SessionHistoryManager, sessionTypes: SessionTypeManager) {
        self.historyManager = history
        self.sessionTypeManager = sessionTypes
        timer.$secondsRemain
            .receive(on: RunLoop.main)
            .assign(to: \.secondsRemain, on: self)
            .store(in: &cancellables)
        
    }
    
    func editSession(type: SessionType, durationInSeconds: Int) {
        currentSession.set(startTime: nil, type: type, durationInSeconds: durationInSeconds)
        timer.setTimer(newTime: durationInSeconds)
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
}
