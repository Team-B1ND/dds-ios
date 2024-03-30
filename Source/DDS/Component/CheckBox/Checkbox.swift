import SwiftUI

@available(macOS 12, iOS 15, *)
public struct Checkbox: View {
    
    public enum CheckType {
        case primary, error
    }
    
    @Binding private var isChecked: Bool
    private let type: CheckType
    
    public init(
        isChecked: Binding<Bool>,
        type: CheckType = .primary
    ) {
        self._isChecked = isChecked
        self.type = type
    }
    
    public var body: some View {
        Button {
            isChecked.toggle()
        } label: {
            Group {
                if isChecked {
                    ZStack {
                        Rectangle()
                            .dodamFill(
                                type == .primary
                                ? .primary
                                : .error
                            )
                            .frame(width: 18, height: 18)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                        Image(icon: .checkmark)
                            .resizable()
                            .dodamColor(
                                type == .primary
                                ? .onPrimary
                                : .onError
                            )
                            .padding(4)
                    }
                } else {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Dodam.color(.onSurfaceVariant), lineWidth: 2)
                        .frame(width: 18, height: 18)
                }
                
            }
            .frame(width: 40, height: 40)
        }
    }
}

#Preview {
    struct CheckboxPreview: View {
        
        @State var isChecked: Bool = true
        
        var body: some View {
            VStack(spacing: 20) {
                Checkbox(isChecked: $isChecked)
                Checkbox(isChecked: $isChecked, type: .error)
            }
            .padding(16)
            .background(Dodam.color(.surface))
        }
    }
    return CheckboxPreview()
}
