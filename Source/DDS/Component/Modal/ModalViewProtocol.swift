import SwiftUI

protocol ModalViewProtocol: View {
    associatedtype C: View
    
    var content: () -> C { get }
    
    func dismiss()
}
