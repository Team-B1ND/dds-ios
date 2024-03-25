import SwiftUI

@available(macOS 12, iOS 15, *)
public struct DodamCircularProgressView: View {
    
    private let progress: CGFloat
    private let backgroundColor: Color?
    private let isDisabled: Bool
    
    public init(
        progress: CGFloat,
        backgroundColor: Color? = nil,
        isDisabled: Bool = false
    ) {
        self.progress = progress
        self.backgroundColor = backgroundColor
        self.isDisabled = isDisabled
    }
    
    public func backgroundColor(_ dodamColor: DodamColor) -> Self {
        .init(
            progress: self.progress,
            backgroundColor: dodamColor.rawValue,
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
    
    private var foregroundColor: AnyShapeStyle {
        isDisabled ? .init(Dodam.color(.tertiary)) : .init(.tint)
    }
    
    public var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 10)
                .foregroundStyle(
                    backgroundColor ?? Dodam.color(.secondary)
                )
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
                .foregroundStyle(foregroundColor)
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
                    .backgroundColor(.error)
                Slider(value: $progress)
                    .tint(.gray)
            }
            .padding()
        }
    }
    return DodamCircularProgressPreview()
}
