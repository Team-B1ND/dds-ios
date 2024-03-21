import SwiftUI

@available(macOS 12, iOS 15, *)
public struct DodamScrollView<I: View, C: View>: View {
    
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
        ScrollView(showsIndicators: false) {
            content()
        }
        .frame(maxWidth: .infinity)
        .overlay(alignment: .top) {
            HStack {
                navigationBarItem()
            }
            .frame(height: 58)
            .frame(maxWidth: .infinity)
            .background(.regularMaterial)
        }
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
