import SwiftUI

@available(macOS 12, iOS 15, *)
public extension View {
    
    @ViewBuilder
    func dodamModal<C: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> C
    ) -> some View {
        DodamModal(
            isPresented: isPresented,
            content: content
        ) {
            self
        }
    }
}
