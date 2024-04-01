import SwiftUI

@available(macOS 12, iOS 15, *)
public struct DodamScrollView<C: View>: NavigationViewProtocol {
    
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
        ScrollView(showsIndicators: false) {
            content()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .safeAreaInset(edge: .top) {
            applyButton(bar: navigationBar)
                .background(.bar)
        }
    }
}

#Preview {
    DodamScrollView.large(title: "Title") {
        Text("Hello")
            .font(.largeTitle)
    }
    .button(icon: .plus) { }
    .button(icon: .bell) { }
}
