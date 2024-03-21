import SwiftUI

@available(macOS 12, iOS 15, *)
public struct DodamScrollView<C: View>: View {
    
    private let title: String
    private let content: C
    
    public init(
        title: String,
        @ViewBuilder content: @escaping () -> C
    ) {
        self.title = title
        self.content = content
    }
    
    public var body: some View {
        ScrollView(showsIndicators: false) {
            content()
        }
        .frame(maxWidth: .infinity)
        .overlay(alignment: .top) {
            HStack {
                Text(title)
                    .font(.headline(.large))
                    .dodamColor(.onBackground)
                    .padding(.leading, 20)
                Spacer()
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

#Preview {
    DodamScrollView(title: "title") {
        Text("Scroll Item")
    }
}
