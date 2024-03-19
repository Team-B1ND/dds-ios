import SwiftUI

@available(macOS 12, iOS 15, *)
public struct DodamModal<C: View, V: View>: View {
    
    @Binding private var isPresented: Bool
    private let content: () -> C
    private let view: () -> V
    
    public init(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> C,
        @ViewBuilder view: @escaping () -> V
    ) {
        self.animatedPresentation = isPresented.wrappedValue
        self._isPresented = isPresented
        self.content = content
        self.view = view
    }
    
    @State private var animatedPresentation: Bool
    @State private var startOffset: CGFloat?
    @State private var dragOffset: CGFloat = 0
    
    public var body: some View {
        view()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onChange(of: isPresented) { newValue in
                withAnimation(.spring(duration: 0.3)) {
                    animatedPresentation = newValue
                }
            }
            .overlay(
                GeometryReader { geometryProxy in
                    ZStack(alignment: .bottom) {
                        Color.black
                            .opacity(animatedPresentation ? 0.5 : 0)
                            .ignoresSafeArea()
                            .onTapGesture {
                                isPresented = false
                            }
                        if animatedPresentation {
                            Dodam.color(.background)
                                .frame(height: -min(dragOffset, 0))
                            let bottomSafeArea = geometryProxy.safeAreaInsets.bottom
                            content()
                                .padding([.top, .horizontal], 24)
                                .padding(
                                    .bottom,
                                    bottomSafeArea == 0 ? 24 : bottomSafeArea
                                )
                                .frame(maxWidth: .infinity)
                                .background(Dodam.color(.background))
                                .clipShape(DodamModalShape())
                                .offset(y: dragOffset)
                                .transition(.move(edge: .bottom))
                                .zIndex(1)
                                .simultaneousGesture(
                                    DragGesture(minimumDistance: 0, coordinateSpace: .local)
                                        .onChanged { newValue in
                                            let offset = newValue.location.y
                                            if startOffset == nil {
                                                startOffset = offset
                                            }
                                            if let startOffset {
                                                let value = -(startOffset - offset)
                                                dragOffset = value < 0 ? value / 5 : value
                                            }
                                        }
                                        .onEnded { _ in
                                            startOffset = nil
                                            if dragOffset > geometryProxy.size.height / 8 {
                                                isPresented = false
                                            }
                                            withAnimation(.spring) {
                                                dragOffset = 0
                                            }
                                        }
                                )
                        }
                    }
                    .ignoresSafeArea()
                }
            )
    }
}

#Preview {
    struct DodamModalPreview: View {
        
        @State private var isPresented: Bool = false
        
        var body: some View {
            DodamButton.medium(
                title: "Toggle"
            ) {
                isPresented.toggle()
            }
            .dodamModal(isPresented: $isPresented) {
                Text("Presented")
            }
        }
    }
    return DodamModalPreview()
}
