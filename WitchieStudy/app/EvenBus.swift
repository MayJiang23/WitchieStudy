import Combine

final class EventBus {
    static let shared = EventBus()
    private init() {}
    
    private let subject = PassthroughSubject<any AppEvent, Never>()
    
    func publish(_ event: any AppEvent) {
        subject.send(event)
    }
    
    func subscribe<T>(to eventType: T.Type, perform action: @escaping (T) -> Void) -> AnyCancellable {
        return subject
            .compactMap { $0 as? T }
            .sink { action($0) }
    }
}
