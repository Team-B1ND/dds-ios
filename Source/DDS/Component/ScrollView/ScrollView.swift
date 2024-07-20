import SwiftUI

@available(macOS 12, iOS 15, *)
public struct DodamScrollView<C: View>: DodamNavigationViewProtocol {
    
    public let borderSize: CGFloat?
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
            borderSize: borderSize,
            topAppBar: topAppBar,
            buttons: buttons,
            subView: subView,
            content: content
        )
    }
    
    public func borderSize(
        _ size: CGFloat
    ) -> Self {
        Self.makeView(
            borderSize: size,
            topAppBar: self.topAppBar,
            buttons: self.buttons,
            subView: self.subView,
            content: self.content
        )
    }
    
    @Environment(\.tabViewIdx) var tabViewIdx: Int?
    @State private var topInset: CGFloat!
    @State private var blueOpacity: CGFloat = 0
    
    public var body: some View {
        ScrollView(showsIndicators: false) {
            content()
                .frame(maxWidth: .infinity)
                .padding(.top, -8)
                .background(
                    GeometryReader { insideProxy in
                        let yCoordinate = insideProxy.frame(in: .global).minY
                        Color.clear
                            .onAppear {
                                if topInset == nil {
                                    topInset = yCoordinate
                                }
                            }
                            .onChange(of: yCoordinate) {
                                let scrollOffset = -(($0 - topInset) / (borderSize ?? 0))
                                blueOpacity = max(min(scrollOffset, 1), 0)
                            }
                    }
                )
                .id("ScrollToTop-\(tabViewIdx ?? -1)")
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
            applyBar(bar: topAppBar)
                .background(.bar.opacity(blueOpacity))
        }
        .safeAreaInset(edge: .bottom) {
            Spacer()
                .frame(height: 150)
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
    .registerSUIT()
}
