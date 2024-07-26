import Foundation

protocol ModalProvider: ObservableObject {
    var isPresent: Bool { get }
}
