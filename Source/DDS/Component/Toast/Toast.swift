import SwiftUI
import Combine

@available(macOS 12, iOS 15, *)
public struct DodamToast<C: View, V: View>: View {
    
    @State private var isPresented: Binding<Bool>?
    private let timeout: Double?
    private let content: () -> C
    private let view: () -> V
    
    public init(
        isPresented: Binding<Bool>?,
        timeout: Double?,
        @ViewBuilder content: @escaping () -> C,
        @ViewBuilder view: @escaping () -> V
    ) {
        self.isPresented = isPresented
        self.animatedPresentation = isPresented?.wrappedValue ?? false
        self.timeout = timeout
        self.content = content
        self.view = view
    }
    
    @State private var unwrappedPresentation: Bool = false
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
        .onChange(of: unwrappedPresentation) { newValue in
            withAnimation(.spring(duration: 0.2)) {
                animatedPresentation = newValue
            }
            if newValue, let timeout {
                let time = 1_000_000_000 * UInt64(timeout)
                Task {
                    try? await Task.sleep(nanoseconds: time)
                    unwrappedPresentation = false
                    if isPresented != nil {
                        isPresented?.wrappedValue = false
                    }
                }
            }
        }
        .onReceive(Just(isPresented)) { newValue in
            if let newValue {
                unwrappedPresentation = newValue.wrappedValue
            }
        }
        .onAppear {
            if isPresented == nil {
                unwrappedPresentation = true
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
            .registerSUIT()
        }
    }
    return DodamToastPreview()
}
