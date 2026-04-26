import Foundation

protocol AppEvent {
    associatedtype AppData
    func getData(_ config: Any?) -> AppData?
}
