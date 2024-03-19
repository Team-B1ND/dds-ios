import SwiftUI

@available(macOS 12, iOS 15, *)
public extension Shape {
    
    func dodamFill(_ dodamColor: DodamColor) -> some View {
        self
            .fill(dodamColor.rawValue)
    }
}
