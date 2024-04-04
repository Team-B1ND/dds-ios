import SwiftUI

@available(macOS 12, iOS 15, *)
public extension View {
    
    @ViewBuilder
    func registerSUIT() -> some View {
        {
            SUIT.register()
            return self
        }()
    }
}
