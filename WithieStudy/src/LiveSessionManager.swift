//
//  LiveSessionManager.swift
//  WithieStudy
//
//
import Foundation
import Combine


class LiveSessionManager: ObservableObject {
    @Published var secondsRemain: Int = 1500
    @Published var currentType: SessionType = SessionType(title: "Work")
    @Published var isActive: Bool = false
    @Published var currentSession: ProductivitySession = ProductivitySession(startTime: Date.now, durationInSeconds: 1500, type: SessionType(title: "Work"))

    private var timer: Timer?
    
    var historyManager: SessionHistoryManager
    var sessionTypeManager: SessionTypeManager
    
    var timeFormatted: String {
        let minutes = secondsRemain / 60
        let seconds = secondsRemain % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    
    init(history: SessionHistoryManager, sessionTypes: SessionTypeManager) {
        self.historyManager = history
        self.sessionTypeManager = sessionTypes
    }
    
    func editSession(type: SessionType, durationInSeconds: Int) {
        currentSession.type = type
        currentType = type
        secondsRemain = durationInSeconds
        currentSession.durationInSeconds = durationInSeconds
    }
    
    func start() {
        currentSession.startTime = Date.now
        resumeTimer()
    }
    
    func resumeTimer() {
        isActive = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {
            _ in
            if self.secondsRemain > 0 {
                self.secondsRemain -= 1
            } else {
                self.finish()
            }
        }
    }
    
    func pauseTimer() {
        isActive = false
        timer?.invalidate()
    }
    
    func resetTimer() {
        secondsRemain = currentSession.durationInSeconds
    }
    
    func finish() {
        pauseTimer()
        resetTimer()
        
        let actualTimeSpent = Double(currentSession.durationInSeconds - secondsRemain)
        
        historyManager.addSession(type: currentType, duration: actualTimeSpent, dateCompleted: Date.now, notes: "A productivy time had passed...")
        
    }
}
