import SwiftUI

@available(macOS 12, iOS 15, *)
public struct DodamLoadingView: View {
    
    @State private var loadingState: Int = -1
    
    public init() { }
    
    public var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<3) { idx in
                let opacity = loadingState == idx ? 1 : 0.1
                Circle()
                    .dodamFill(DodamColor.Label.alternative)
                    .opacity(opacity)
                    .frame(width: 8, height: 8)
            }
        }
        .onChange(of: loadingState) { newValue in
            Task.detached {
                try? await Task.sleep(nanoseconds: 300_000_000)
                withAnimation(.spring(duration: 0.5)) {
                    loadingState = (newValue + 1) % 3
                }
            }
        }
        .onAppear {
            loadingState = 0
        }
    }
}

#Preview {
    DodamLoadingView()
        .registerPretendard()
}
