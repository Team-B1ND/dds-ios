import SwiftUI

#if os(iOS)
@available(macOS 12, iOS 15, *)
public struct DodamNavigationView<C: View>: DodamNavigationViewProtocol {
    
    public let topAppBar: DodamTopAppBar
    public let buttons: [DodamTopAppBarButton]
    public let subView: AnyView?
    public let content: () -> C
    
    public static func makeView(
        borderSize: CGFloat? = nil,
        topAppBar: DodamTopAppBar,
        buttons: [DodamTopAppBarButton] = [],
        subView: AnyView? = nil,
        @ViewBuilder content: @escaping () -> C
    ) -> Self {
        .init(
            topAppBar: topAppBar,
            buttons: buttons,
            subView: subView,
            content: content
        )
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            applyBar(bar: topAppBar)
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
    .registerPretendard()
}
#endif
