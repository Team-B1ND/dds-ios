import SwiftUI

@available(macOS 12, iOS 15, *)
public struct Checkbox: View {
    
    public enum CheckType {
        case primary, error
    }
    
    @Binding private var isChecked: Bool
    private let type: CheckType
    private let isDisabled: Bool
    
    public init(
        isChecked: Binding<Bool>,
        type: CheckType = .primary,
        isDisabled: Bool = false
    ) {
        self._isChecked = isChecked
        self.type = type
        self.isDisabled = isDisabled
    }
    
    public var body: some View {
        Button {
            isChecked.toggle()
        } label: {
            Group {
                if isChecked {
                    Image(icon: .checkmark)
                        .resizable()
                        .frame(width: 12, height: 12)
                        .foreground(DodamColor.Static.white)
                        .padding(4)
                        .background {
                            Rectangle()
                                .dodamFill(
                                    type == .primary
                                    ? DodamColor.Primary.normal
                                    : DodamColor.Status.negative
                                )
                                .frame(width: 18, height: 18)
                                .clipShape(RoundedRectangle(cornerRadius: 4))
                        }
                } else {
                    RoundedRectangle(cornerRadius: 4)
                        .dodamStroke(DodamColor.Line.normal, lineWidth: 2)
                        .frame(width: 18, height: 18)
                }
            }
            .padding(3)
        }
        .frame(width: 40, height: 40)
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.5 : 1)
    }
}

#Preview {
    struct CheckboxPreview: View {
        @State var isChecked: Bool = true
        
        var body: some View {
            VStack(spacing: 20) {
                Checkbox(isChecked: $isChecked)
                Checkbox(isChecked: $isChecked, type: .error)
                Checkbox(isChecked: $isChecked, isDisabled: true)
            }
            .padding(16)
            .background(DodamColor.Background.normal)
            .registerSUIT()
        }
    }
    return CheckboxPreview()
}
