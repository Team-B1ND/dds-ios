import SwiftUI

@available(macOS 12, iOS 15, *)
public extension View {
    
    func page(_ label: DodamPage.Label = .none) -> DodamPage {
        .init(label) { self }
    }
}
