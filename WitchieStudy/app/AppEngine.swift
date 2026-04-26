import Combine
import SwiftData

@Observable
class AppEngine {
    var sessionState: SessionState
    var gameState: GameState
    
    var modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.sessionState = SessionState(modelContext)
        self.gameState = GameState(modelContext)
        self.setupInternalConnections()
    }
    
    private func distribute(_ action: SessionAction) {
        gameState.handle(action)
        sessionState.handle(action)
    }
    
    private func setupInternalConnections() {
        self.sessionManager.onTick = { [weak self] in
            if let item = self?.loot.attemptLoot() {
                self?.inventory.addItem(item: item)
                
                let event = ItemFoundEvent(items: [item])
                self?.report.addEvents(events: [event])
            }
        }
        
        self.sessionManager.onFinish = { [weak self] actualTimeSpent, sessionType in
            guard let self = self else { return }
                    
            // Award currency: 1 coin per minute spent
            let minutesSpent = Int(actualTimeSpent / 60)
            let currencyEarned = max(minutesSpent, 1)
            self.player.addCurrency(currencyEarned)
                
            // Award stat increase based on session type's theme action
            let statType = sessionType.themeAction.statType
            let statGain = max(minutesSpent / 5, 1)
            self.player.increaseStat(statType, by: statGain)
        }
    }
}
