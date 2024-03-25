import SwiftUI

@available(macOS 12, iOS 15, *)
public extension View {
    
    @ViewBuilder
    func shimmer(_ condition: Bool = true) -> some View {
        DodamShimmer { self }
    }
}
