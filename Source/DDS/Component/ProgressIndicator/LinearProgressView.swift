import SwiftUI

@available(macOS 12, iOS 15, *)
public struct DodamLinearProgressView: View {
    
    private let progress: CGFloat
    private let isDisabled: Bool
    
    public init(
        progress: CGFloat,
        isDisabled: Bool = false
    ) {
        self.progress = progress
        self.isDisabled = isDisabled
    }
    
    public func disabled(_ condition: Bool = true) -> Self {
        .init(
            progress: self.progress,
            isDisabled: condition
        )
    }
    
    @State private var animatedProgress: CGFloat = 0
    
    private var foregroundColor: DodamColorable {
        isDisabled ? DodamColor.Line.normal : DodamColor.Primary.normal
    }
    
    public var body: some View {
        GeometryReader { geometryProxy in
            ZStack(alignment: .leading) {
                Capsule()
                    .foreground(DodamColor.Line.alternative)
                let width = geometryProxy.size.width
                Capsule()
                    .frame(width: width * animatedProgress)
                    .foreground(foregroundColor)
            }
        }
        .frame(height: 14)
        .onChange(of: progress) { newValue in
            animatedProgress = newValue
        }
        .onAppear {
            withAnimation(.spring) {
                animatedProgress = progress
            }
        }
    }
}

#Preview {
    struct DodamLinearProgressPreview: View {
        
        @State private var progress: CGFloat = 0.5
        
        var body: some View {
            VStack(spacing: 20) {
                DodamLinearProgressView(progress: progress)
                Slider(value: $progress)
                    .tint(.gray)
            }
            .padding()
            .registerPretendard()
        }
    }
    return DodamLinearProgressPreview()
}
