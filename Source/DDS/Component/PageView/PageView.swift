import SwiftUI
import Combine

@available(macOS 12, iOS 15, *)
public struct DodamPageView: View {
    
    private let contents: [DodamPage]
    
    public init(
        selection: Binding<Int>? = nil,
        @DodamPage.Builder contents: () -> [DodamPage]
    ) {
        self.selection = selection
        self.selected = selection?.wrappedValue ?? 0
        self.contents = contents()
    }
    
    @State private var selection: Binding<Int>?
    @State private var selected: Int
    
    public var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            TabView(selection: $selected) {
                ForEach(contents.indices, id: \.self) { idx in
                    contents[idx].content
                        .tag(idx)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            HStack(spacing: 5) {
                ForEach(contents.indices, id: \.self) { idx in
                    Circle()
                        .dodamFill(selected == idx ? DodamColor.Primary.normal : DodamColor.Label.disable)
                        .frame(width: 5, height: 5)
                }
            }
        }
        .onChange(of: selected) { newValue in
            selection?.wrappedValue = newValue
        }
        .onReceive(Just(selection)) { newValue in
            if let newValue,
               selected != newValue.wrappedValue {
                withAnimation(.spring) {
                    selected = newValue.wrappedValue
                }
            }
        }
    }
}


private struct DodamPagePreview: View {
    
    @State private var selection: Int = 0
    
    var body: some View {
        DodamPageView(selection: $selection) {
            Button("Next") {
                selection += 1
            }
            .page()
            Button("Next") {
                selection += 1
            }
            .page()
            Button("First") {
                selection = 0
            }
            .page()
        }
        .frame(height: 50)
        .padding()
        .registerPretendard()
    }
}

#Preview {
    DodamPagePreview()
}

#Preview {
    DodamPagePreview()
        .preferredColorScheme(.dark)
}
