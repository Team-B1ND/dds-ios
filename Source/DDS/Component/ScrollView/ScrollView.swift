import SwiftUI

@available(macOS 12, iOS 15, *)
public struct DodamScrollView<I: View, C: View>: View {
    
    @State private var navigationBarHeight: CGFloat = 0
    
    private let navigationBarItem: () -> I
    private let content: () -> C
    
    public init(
        @ViewBuilder item: @escaping () -> I,
        @ViewBuilder content: @escaping () -> C
    ) {
        self.navigationBarItem = item
        self.content = content
    }
    
    public var body: some View {
        ZStack(alignment: .top) {
            ScrollView(showsIndicators: false) {
                content()
                    .padding(.top, navigationBarHeight)
            }
            navigationBarItem()
                .background(
                    GeometryReader { geometryProxy in
                        Color.clear
                            .onAppear {
                                navigationBarHeight = geometryProxy.size.height
                            }
                    }
                )
        }
        .frame(maxWidth: .infinity)
        .overlay(alignment: .bottom) {
            VStack {
                Spacer()
                LinearGradient(
                    gradient: Gradient(colors: [
                        Dodam.color(.surface).opacity(0),
                        Dodam.color(.surface)
                    ]), startPoint: .top, endPoint: .bottom
                )
                .frame(height: 170)
                .frame(maxWidth: .infinity)
            }
            .ignoresSafeArea()
        }
        .background(Dodam.color(.surface))
    }
}

#Preview {
    DodamScrollView {
        HStack {
            Text("도담 스크롤")
                .font(.headline(.small))
                .dodamColor(.onBackground)
                .padding(.leading, 20)
            Spacer()
        }
        .frame(height: 58)
        .frame(maxWidth: .infinity)
        .background(.regularMaterial)
    } content: {
        VStack {
            ForEach(0..<10) { _ in
                Text("도담 스크롤 콘텐츠")
            }
        }
    }
}
