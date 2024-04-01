import SwiftUI

@available(macOS 12, iOS 15, *)
public struct DodamScrollView<C: View>: NavigationViewProtocol {
    
    public let navigationBar: DodamNavigationBar
    public let buttons: [DodamNavigationBarButton]
    public let subView: AnyView?
    public let content: () -> C
    
    public init(
        navigationBar: DodamNavigationBar,
        buttons: [DodamNavigationBarButton] = .init(),
        subView: AnyView? = nil,
        @ViewBuilder content: @escaping () -> C
    ) {
        self.navigationBar = navigationBar
        self.buttons = buttons
        self.subView = subView
        self.content = content
    }
    
    public var body: some View {
        ScrollView(showsIndicators: false) {
            content()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .safeAreaInset(edge: .top) {
            applyBar(bar: navigationBar)
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
