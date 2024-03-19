import SwiftUI

@available(macOS 12, iOS 15, *)
public extension View {
    
    func dodamColor(_ dodamColor: DodamColor) -> some View {
        self
            .foregroundStyle(dodamColor.rawValue)
    }
}
