import SwiftUI

@available(macOS 12, iOS 15, *)
public struct DodamToast<C: View, V: View>: View {
    
    @Binding private var isPresented: Bool
    private let timeout: Double?
    private let content: () -> C
    private let view: () -> V
    
    public init(
        isPresented: Binding<Bool>,
        timeout: Double?,
        @ViewBuilder content: @escaping () -> C,
        @ViewBuilder view: @escaping () -> V
    ) {
        self._isPresented = isPresented
        self.animatedPresentation = isPresented.wrappedValue
        self.timeout = timeout
        self.content = content
        self.view = view
    }
    
    @State private var animatedPresentation: Bool
    
    public var body: some View {
        ZStack(alignment: .top) {
            view()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            if animatedPresentation {
                content()
                    .padding(.vertical, 15)
                    .padding(.horizontal, 40)
                    .background(Color(.tertiarySystemBackground))
                    .clipShape(Capsule())
                    .shadow(color: Color.black.opacity(0.08), radius: 2, y: 1)
                    .shadow(color: Color.black.opacity(0.08), radius: 5, y: 4)
                    .transition(
                        .move(edge: .top)
                        .combined(with: .opacity)
                    )
            }
        }
        .onChange(of: isPresented) { newValue in
            withAnimation(.spring(duration: 0.2)) {
                animatedPresentation = newValue
            }
            if newValue, let timeout {
                let time = 1_000_000_000 * UInt64(timeout)
                Task {
                    try? await Task.sleep(nanoseconds: time)
                    isPresented = false
                }
            }
        }
    }
}

#Preview {
    struct DodamToastPreview: View {
        
        @State private var isPresented: Bool = false
        
        var body: some View {
            Button("Present") {
                isPresented.toggle()
            }
            .toast(
                isPresented: $isPresented,
                timeout: 3
            ) {
                Text("Hello, world!")
            }
        }
    }
    return DodamToastPreview()
}
