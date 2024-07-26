import Foundation
import SwiftUI

struct BaseModal<MC: View, C: View>: View {
    
    @Namespace var animation
    @State private var scaleEffect: CGFloat = 1.2
    @Binding var isPresent: Bool
    @State var opacity: Double = 0.0
    let backgroundColor: DodamColorable = DodamColor.Background.normal
    let cornerRadius: CGFloat = 16
//    let shadow: SeugiShadowSystem = .evBlack(.ev1)
    @ViewBuilder let modalContent: () -> MC
    @ViewBuilder let content: () -> C
    
    var body: some View {
        ZStack {
            content()
            Color.black
                .opacity(0.2 * opacity)
                .ignoresSafeArea()
            // MARK: - Modal Content
            VStack {
                Spacer()
                if isPresent {
                    modalContent()
                        .background(backgroundColor)
                        .cornerRadius(cornerRadius)
    //                    .shadow(shadow)
                        .scaleEffect(scaleEffect)
                        .opacity(opacity)
                } else {
                    modalContent()
                        .background(backgroundColor)
                        .cornerRadius(cornerRadius)
    //                    .shadow(shadow)
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
