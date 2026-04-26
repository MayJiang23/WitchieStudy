import SwiftData
import Foundation


@ModelActor
actor DataCoordinator {
    static let shared = DataCoordinator()
        
    let container: ModelContainer
    let context: ModelContext
    
    private init() {
        self.container = try! ModelContainer(for: ProductivitySession.self, SessionType.self, Inventory.self, PlayerCharacter.self, RelationshipState.self)
        self.context = ModelContext(container)
    }
    
    func getOrCreate<T: PersistentModel>(
        _ descriptor: FetchDescriptor<T>,
        onCreate: (@Sendable () -> T)? = nil
    ) -> [T] {
        if T.self == ProductivitySession.self {
            return createDefaultSession() as! [T]
        }
        
        if let existing = self.get(descriptor) {
            return existing
        }
        
        let newInstance: T
        if let create = onCreate {
            newInstance = create()
        } else {
            fatalError("Type \(T.self) needs an onCreate closure or DefaultInitializable conformance")
        }
        
        context.insert(newInstance)
        return [newInstance]
    }
    
    func insert(_ models: [any PersistentModel]) {
        for model in models {
            self.context.insert(model)
        }
    }
    
    func get<T: PersistentModel>(_ descriptor: FetchDescriptor<T>) -> [T]? {
        do {
            let existing = try self.context.fetch(descriptor)
            return existing
        } catch {
            print("Fetch failed: \(error)")
            return nil
        }
    }
    
    func save() {
        do {
            try self.context.save()
        } catch {
            print("Save failed: \(error)")
        }
    }
    
    func delete<T: PersistentModel>(type: T.Type, descriptor: FetchDescriptor<T>) {
        do {
            let itemsToDelete = try self.context.fetch(descriptor)
                    
            for item in itemsToDelete {
                self.context.delete(item)
            }
            save()
        } catch {
            print("Delete \(type) failed: \("error")")
        }
    }
    
    func deleteAll(type: any PersistentModel.Type) {
        do {
            try self.context.delete(model: type)
        } catch {
            print("Delete all failed: \(error)")
        }
    }
    
    private func createDefaultSession() -> [ProductivitySession] {
        let initialType = getOrCreate(FetchDescriptor<SessionType>(), onCreate: SessionType.createDefault)
        let initialSession = ProductivitySession(
            startTime: Date.now,
            durationInSeconds: 1500,
            type: initialType.first!,
            secondsRemain: 1500
        )
        insert([initialSession])
        return [initialSession]
    }
    
}
