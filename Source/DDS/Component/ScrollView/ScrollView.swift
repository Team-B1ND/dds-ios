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
            content()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    GeometryReader { insideProxy in
                        EmptyView()
                            .onChange(of: insideProxy.frame(in: .global).minY) {
                                if topInset == nil {
                                    topInset = $0
                                }
                                let scrollOffset = $0 - topInset
                                blueOpacity = max(min(-(scrollOffset / 16), 1), 0)
                            }
                    }
                )
        }
        .mask(alignment: .bottom) {
            VStack(spacing: 0) {
                Color.black
                LinearGradient(
                    colors: [.black, .clear],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 150)
            }
            .ignoresSafeArea()
        }
        .safeAreaInset(edge: .top) {
            applyBar(bar: navigationBar)
                .background(.bar.opacity(blueOpacity))
        }
    }
}

#Preview {
    DodamScrollView.large(title: "Title") {
        VStack {
            ForEach(0..<500) { _ in
                Text("Hello")
                    .font(.largeTitle)
            }
        }
    }
    .button(icon: .plus) { }
    .button(icon: .bell) { }
}
