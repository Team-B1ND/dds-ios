import SwiftUI

@available(macOS 12, iOS 15, *)
public struct DodamNavigationView<C: View>: NavigationViewProtocol {
    
    internal let navigationBar: DodamNavigationBar
    internal let buttons: [DodamNavigationBarButton]
    internal let subView: AnyView?
    internal let content: () -> C
    
    public var body: some View {
        VStack(spacing: 0) {
            applyBar(bar: navigationBar)
            content()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    DodamNavigationView.large(title: "Title") {
        Text("Hello")
    }
    .button(icon: .plus) { }
    .button(icon: .bell) { }
}
