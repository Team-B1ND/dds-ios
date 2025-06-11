import Foundation
import SwiftUI

#if os(iOS)
struct BaseModal<MC: View, C: View>: View {
    @Namespace var animation
    @State private var scaleEffect: CGFloat = 1.2
    @Binding var isPresent: Bool
    @State var opacity: Double = 0.0
    let backgroundColor: DodamColorable = DodamColor.Background.normal
    let cornerRadius: CGFloat = 16
    @ViewBuilder let content: () -> C
    @ViewBuilder let modalContent: () -> MC
    
    var body: some View {
        ZStack {
            content()
            Color.black
                .opacity(0.2 * opacity)
                .ignoresSafeArea()
                .onTapGesture {
                    self.isPresent = false
                }
            // MARK: - Modal Content
            VStack {
                Spacer()
                if isPresent {
                    modalContent()
                        .background(backgroundColor)
                        .cornerRadius(cornerRadius)
                        .scaleEffect(scaleEffect)
                        .opacity(opacity)
                } else {
                    modalContent()
                        .background(backgroundColor)
                        .cornerRadius(cornerRadius)
                        .opacity(opacity)
                }
                Spacer()
            }
        }
        .onChange(of: isPresent) { isPresent in
            withAnimation(.easeOut(duration: 0.2)) {
                opacity = isPresent ? 1 : 0
                scaleEffect = isPresent ? 1 : 1.1
            }
        }
    }
}
#endif
