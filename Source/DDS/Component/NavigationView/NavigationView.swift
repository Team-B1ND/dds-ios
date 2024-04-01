import SwiftUI

@available(macOS 12, iOS 15, *)
public struct DodamNavigationView<C: View>: NavigationViewProtocol {
    
    internal let navigationBar: DodamNavigationBar
    internal let buttons: [DodamNavigationBarButton]
    internal let content: () -> C
    
    public init(
        navigationBar: DodamNavigationBar,
        buttons: [DodamNavigationBarButton] = .init(),
        @ViewBuilder content: @escaping () -> C
    ) {
        self.navigationBar = navigationBar
        self.buttons = buttons
        self.content = content
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            applyButton(bar: navigationBar)
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
