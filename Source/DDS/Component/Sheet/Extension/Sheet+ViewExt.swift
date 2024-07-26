import SwiftUI

@available(macOS 12, iOS 15, *)
public extension View {
    
    @ViewBuilder
    func dodamSheet<C: View>(
        isPresented: Binding<Bool>,
        disableGesture: Bool = false,
        @ViewBuilder content: @escaping () -> C
    ) -> some View {
        DodamSheet(
            isPresented: isPresented,
            disableGesture: disableGesture,
            content: content
        ) {
            self
        }
    }
}
