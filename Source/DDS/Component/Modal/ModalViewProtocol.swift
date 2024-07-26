import SwiftUI

protocol ModalViewProtocol: View {
    associatedtype P: ModalProvider
    associatedtype C: View
    
    var content: () -> C { get }
    
    func dismiss()
}
