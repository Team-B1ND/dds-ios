import SwiftUI

#if os(iOS)
@available(macOS 12, iOS 15, *)
public extension View {
    
    @ViewBuilder
    func toast<C: View>(
        isPresented: Binding<Bool>? = nil,
        timeout: Double? = nil,
        @ViewBuilder content: @escaping () -> C
    ) -> some View {
        DodamToast(
            isPresented: isPresented,
            timeout: timeout,
            content: content
        ) { self }
    }
}
#endif
