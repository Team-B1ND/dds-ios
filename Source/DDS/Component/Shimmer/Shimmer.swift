import SwiftUI

@available(macOS 12, iOS 15, *)
public struct DodamShimmer<C: View>: View {
    
    private let content: () -> C
    
    public init(@ViewBuilder content: @escaping () -> C) {
        self.content = content
    }
    
    @State private var startPoint: UnitPoint = .init(x: -1.8, y: -1.2)
    @State private var endPoint: UnitPoint = .init(x: 0, y: -0.2)
    
    public var body: some View {
        content()
            .redacted(reason: .placeholder)
            .mask(
                LinearGradient(
                    colors: [
                        .gray.opacity(0.6),
                        .gray.opacity(0.2),
                        .gray.opacity(0.6)
                    ],
                    startPoint: startPoint,
                    endPoint: endPoint
                )
            )
            .onAppear {
                withAnimation(
                    .linear(duration: 0.8)
                    .repeatForever(autoreverses: false)
                ) {
                    startPoint = .init(x: 1, y: 1)
                    endPoint = .init(x: 2.2, y: 2.2)
                }
            }
    }
}

#Preview {
    VStack {
        Text("Hello, world!")
        Circle()
            .frame(width: 100, height: 100)
    }
    .shimmer()
    .registerSUIT()
}
