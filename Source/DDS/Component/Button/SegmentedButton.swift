import SwiftUI
import Combine

#if os(iOS)
public struct DodamSegmentedButton: View {
    
    private let labels: [String]
    
    public init(
        labels: [String],
        selection: Binding<Int>? = nil
    ) {
        self.labels = labels
        self.selection = selection
        let selected = selection?.wrappedValue ?? 0
        self.selected = selected
        self.animatedSelection = selected
    }
    
    @Namespace private var animation
    @State private var selection: Binding<Int>?
    @State private var selected: Int
    @State private var animatedSelection: Int
    
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(labels.enumerated()), id: \.offset) { idx, label in
                let isSelected = animatedSelection == idx
                Button {
                    if selected != idx {
                        selected = idx
                    }
                } label: {
                    Text(label)
                        .headline(.medium)
                        .foreground(isSelected ? DodamColor.Label.normal : DodamColor.Label.assistive)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 6)
                }
                .background {
                    if isSelected {
                        RoundedRectangle(cornerRadius: 10)
                            .dodamFill(DodamColor.Fill.assistive)
                            .matchedGeometryEffect(
                                id: 0,
                                in: animation
                            )
                            .shadow(
                                color: .black.opacity(0.1),
                                radius: 4,
                                x: 2,
                                y: 2
                            )
                    }
                }
            }
        }
        .padding(4)
        .frame(maxWidth: .infinity)
        .background(DodamColor.Fill.neutral)
        .clipShape(.medium)
        .onChange(of: selected) { newValue in
            selection?.wrappedValue = newValue
            withAnimation(.spring(duration: 0.2)) {
                animatedSelection = newValue
            }
        }
        .onReceive(Just(selection)) { newValue in
            if let newValue {
                withAnimation(.spring) {
                    selected = newValue.wrappedValue
                }
            }
        }
    }
}

private struct SegmentedButtonPreview: View {
    var body: some View {
        VStack {
            DodamSegmentedButton(labels: ["외출", "외박"], selection: .constant(1))
                .padding(.horizontal, 16)
            DodamSegmentedButton(labels: ["외출", "외박"], selection: .constant(0))
                .padding(.horizontal, 16)
        }
        .registerPretendard()
    }
}

#Preview {
   SegmentedButtonPreview()
}

#Preview {
    SegmentedButtonPreview()
        .preferredColorScheme(.dark)
}
#endif
