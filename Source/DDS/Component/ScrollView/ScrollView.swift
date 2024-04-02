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
    
    @State private var topInset: CGFloat!
    @State private var blueOpacity: CGFloat = 0
    
    public var body: some View {
        ScrollView(showsIndicators: false) {
            GeometryReader { insideProxy in
                content()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onChange(of: insideProxy.frame(in: .global).minY) {
                        if topInset == nil {
                            topInset = $0
                        }
                        let scrollOffset = $0 - topInset
                        blueOpacity = max(min(-(scrollOffset / 16), 1), 0)
                    }
            }
        }
        .safeAreaInset(edge: .top) {
            applyBar(bar: navigationBar)
                .background(.bar.opacity(blueOpacity))
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
