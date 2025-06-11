import SwiftUI

#if os(iOS)
@available(macOS 12, iOS 15, *)
public struct DodamSheet<C: View, V: View>: View {
    
    @Binding private var isPresented: Bool
    private let disableGesture: Bool
    private let content: () -> C
    private let view: () -> V
    
    public init(
        isPresented: Binding<Bool>,
        disableGesture: Bool,
        @ViewBuilder content: @escaping () -> C,
        @ViewBuilder view: @escaping () -> V
    ) {
        self.animatedPresentation = isPresented.wrappedValue
        self._isPresented = isPresented
        self.disableGesture = disableGesture
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
                            DodamColor.Background.normal.color.rawValue
                                .frame(height: -min(dragOffset, 0))
                            let bottomSafeArea = geometryProxy.safeAreaInsets.bottom
                            content()
                                .padding([.top, .horizontal], 24)
                                .padding(
                                    .bottom,
                                    bottomSafeArea == 0 ? 24 : bottomSafeArea
                                )
                                .frame(maxWidth: .infinity)
                                .background(DodamColor.Background.normal)
                                .clipShape(DodamSheetShape())
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
                                        },
                                    including: disableGesture ? .subviews : .all
                                )
                        }
                    }
                    .ignoresSafeArea()
                }
            )
    }
}

#Preview {
    struct DodamSheetPreview: View {
        
        @State private var isPresented: Bool = false
        
        var body: some View {
            DodamButton.medium(
                title: "Toggle"
            ) {
                isPresented.toggle()
            }
            .dodamSheet(isPresented: $isPresented) {
                Text("Presented")
            }
            .registerPretendard()
        }
    }
    return DodamSheetPreview()
}

#Preview {
    struct DodamSheetPreview: View {
        
        @State private var isPresented: Bool = false
        @State private var date: Date = .now
        
        var body: some View {
            DodamButton.medium(
                title: "Toggle"
            ) {
                isPresented.toggle()
            }
            .dodamSheet(
                isPresented: $isPresented,
                disableGesture: true
            ) {
                SwiftUI.DatePicker("", selection: $date)
                    .datePickerStyle(.wheel)
            }
            .registerPretendard()
        }
    }
    return DodamSheetPreview()
}

#endif
