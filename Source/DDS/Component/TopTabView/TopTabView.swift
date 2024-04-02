import SwiftUI
import Combine

@available(macOS 12, iOS 15, *)
public struct DodamTopTabView: View {
    
    private let contents: [DodamPage]
    
    public init(
        selection: Binding<Int>? = nil,
        @DodamPage.Builder contents: () -> [DodamPage]
    ) {
        self.selection = selection
        let selected = selection?.wrappedValue ?? 0
        self.selected = selected
        self.animatedSelection = selected
        self.contents = contents()
    }
    
    @Namespace private var animation
    @State private var selection: Binding<Int>?
    @State private var selected: Int
    @State private var animatedSelection: Int
    
    public var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 24) {
                ForEach(contents.indices, id: \.self) { idx in
                    let isSelected = animatedSelection == idx
                    if case let .text(string) = contents[idx].label {
                        Button {
                            if selected != idx {
                                selected = idx
                            }
                        } label: {
                            VStack(spacing: 12) {
                                Text(string)
                                    .font(.body(.large))
                                    .dodamColor(
                                        isSelected ? .onSurface : .onSurfaceVariant
                                    )
                                Group {
                                    if isSelected {
                                        Dodam.color(.onSurface)
                                            .matchedGeometryEffect(
                                                id: 0,
                                                in: animation
                                            )
                                    } else {
                                        Color.clear
                                    }
                                }
                                .frame(height: 2)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 42)
            ForEach(contents.indices, id: \.self) { idx in
                if selected == idx {
                    contents[idx].content
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onChange(of: selected) { newValue in
            selection?.wrappedValue = newValue
            withAnimation(.spring(duration: 0.2)) {
                animatedSelection = newValue
            }
        }
        .onReceive(Just(selection)) { newValue in
            if let newValue,
               selected != newValue.wrappedValue {
                selected = newValue.wrappedValue
            }
        }
    }
}

#Preview {
    struct DodamTopTabPreview: View {
        
        @State private var selection: Int = 0
        
        var body: some View {
            DodamTopTabView(selection: $selection) {
                Text("대기중")
                    .page(.text("대기중"))
                Text("MY")
                    .page(.text("MY"))
            }
        }
    }
    return DodamTopTabPreview()
}
