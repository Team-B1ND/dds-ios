import SwiftUI

@available(macOS 12, iOS 15, *)
public struct DodamCircularProgressView: View {
    
    private let progress: CGFloat
    private let backgroundColor: DodamColorable?
    private let isDisabled: Bool
    
    public init(
        progress: CGFloat,
        backgroundColor: DodamColorable? = nil,
        isDisabled: Bool = false
    ) {
        self.progress = progress
        self.backgroundColor = backgroundColor
        self.isDisabled = isDisabled
    }
    
    public func backgroundColor(_ dodamColor: DodamColorable) -> Self {
        .init(
            progress: self.progress,
            backgroundColor: dodamColor,
            isDisabled: self.isDisabled
        )
    }
    
    public func disabled(_ condition: Bool = true) -> Self {
        .init(
            progress: self.progress,
            backgroundColor: self.backgroundColor,
            isDisabled: condition
        )
    }
    
    @State private var animatedProgress: CGFloat = 0
    
    private var foregroundColor: DodamColorable {
        isDisabled ? DodamColor.Primary.normal : DodamColor.Line.normal
    }
    
    public var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 10)
                .foreground(backgroundColor ?? DodamColor.Line.alternative)
            Circle()
                .trim(from: 0, to: min(animatedProgress, 1))
                .stroke(
                    style:
                        StrokeStyle(
                            lineWidth: 10,
                            lineCap: .round,
                            lineJoin: .round
                        )
                )
                .foreground(foregroundColor)
                .rotationEffect(.degrees(270))
                .animation(.linear, value: progress)
        }
        .frame(width: 70, height: 70)
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
    struct DodamCircularProgressPreview: View {
        
        @State private var progress: CGFloat = 0.5
        
        var body: some View {
            VStack(spacing: 20) {
                DodamCircularProgressView(progress: progress)
                DodamCircularProgressView(progress: progress)
                Slider(value: $progress)
                    .tint(.gray)
            }
            .padding()
            .registerPretendard()
        }
    }
    return DodamCircularProgressPreview()
}
