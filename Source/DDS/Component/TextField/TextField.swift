import SwiftUI

@available(macOS 12, iOS 15, *)
public struct DodamTextField: View {
    
    // MARK: - State
    @FocusState private var focused
    @State private var animatedFocusing: Bool = false
    @State private var isHide = true
    private var isHighlighted: Bool {
        animatedFocusing || !text.isEmpty
    }
    
    // MARK: - parameters
    private let title: String
    @Binding private var text: String
    private let font: Font
    private let supportText: String?
    private let role: TextFieldRole
    private let isEnabled: Bool
    private let isError: Bool
    private let isFirstResponder: Bool
    private let colors: TextFieldColors
    
    private init(
        title: String,
        text: Binding<String>,
        font: Font,
        supportText: String?,
        role: TextFieldRole,
        isEnabled: Bool,
        isError: Bool,
        isFirstResponder: Bool,
        colors: TextFieldColors
    ) {
        self.title = title
        self._text = text
        self.font = font
        self.supportText = supportText
        self.role = role
        self.isEnabled = isEnabled
        self.isError = isError
        self.isFirstResponder = isFirstResponder
        self.colors = colors
    }
    
    public static func `default`(
        title: String = "",
        text: Binding<String>,
        font: Font = .headline(.medium),
        supportText: String? = nil,
        isEnabled: Bool = true,
        isError: Bool = false,
        isFirstResponder: Bool = false,
        colors: TextFieldColors = .default
    ) -> Self {
        .init(
            title: title,
            text: text,
            font: font,
            supportText: supportText,
            role: .default,
            isEnabled: isEnabled,
            isError: isError,
            isFirstResponder: isFirstResponder,
            colors: colors
        )
    }
    
    public static func secured(
        title: String = "",
        text: Binding<String>,
        font: Font = .headline(.medium),
        supportText: String? = nil,
        isEnabled: Bool = true,
        isError: Bool = false,
        isFirstResponder: Bool = false,
        colors: TextFieldColors = .default
    ) -> Self {
        .init(
            title: title,
            text: text,
            font: font,
            supportText: supportText,
            role: .secured,
            isEnabled: isEnabled,
            isError: isError,
            isFirstResponder: isFirstResponder,
            colors: colors
        )
    }
    
    public static func editor(
        title: String = "",
        text: Binding<String>,
        font: Font = .headline(.medium),
        supportText: String? = nil,
        isEnabled: Bool = true,
        isError: Bool = false,
        isFirstResponder: Bool = false,
        colors: TextFieldColors = .default
    ) -> Self {
        .init(
            title: title,
            text: text,
            font: font,
            supportText: supportText,
            role: .editor,
            isEnabled: isEnabled,
            isError: isError,
            isFirstResponder: isFirstResponder,
            colors: colors
        )
    }
    
    public func makeFirstResponder(_ condition: Bool = true) -> Self {
        .init(
            title: title,
            text: _text,
            font: font,
            supportText: supportText,
            role: role,
            isEnabled: isEnabled,
            isError: isError,
            isFirstResponder: condition,
            colors: colors
        )
    }
    
    // MARK: - View
    public var body: some View {
        HStack(spacing: 0) {
            BaseTextField(
                text: $text,
                font: font,
                supportText: supportText,
                role: role,
                isHide: isHide,
                isEnabled: isEnabled,
                isError: isError,
                isFirstResponder: isFirstResponder,
                colors: colors
            )
            TextFieldIcon(
                isHide: isHide,
                role: role,
                isEnabled: !text.isEmpty && focused,
                isError: isError,
                colors: colors
            ) {
                switch role {
                case .default:
                    text = ""
                case .secured:
                    isHide.toggle()
                default:
                    break
                }
            }
        }
        .frame(minHeight: 43)
        .padding(.vertical, 4)
        // Layout
        .overlay {
            Rectangle()
                .foreground(
                    isError
                    ? colors.errorColor
                    : focused
                    ? colors.primaryColor
                    : colors.strokeColor
                )
                .frame(height: 1)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
        .overlay {
            Text(title)
                .foreground(
                    isError
                    ? colors.errorColor
                    : focused
                    ? colors.primaryColor
                    : colors.hintColor
                )
                .scaleEffect(
                    isHighlighted ? 0.75 : 1,
                    anchor: .topLeading
                )
                .padding(.top, isHighlighted ? 0 : 15)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .overlay {
            if let supportText {
                Text(supportText)
                    .label(.medium)
                    .foreground(
                        isError
                        ? colors.errorColor
                        : colors.supportTextColor
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                    .offset(y: 24)
            }
        }
        .onChange(of: focused) { newValue in
            withAnimation(.spring(duration: 0.1)) {
                animatedFocusing = newValue
            }
        }
        .focused($focused)
        .advancedFocus()
        .opacity(isEnabled ? 1 : 0.5)
    }
}


#Preview {
    struct DodamTextFieldPreview: View {
        
        @State private var idText = ""
        @State private var pwText = ""
        
        var body: some View {
            VStack(spacing: 32) {
                DodamTextField.default(
                    title: "아이디",
                    text: $idText,
                    supportText: "20글자 이내"
                )
                DodamTextField.secured(
                    title: "비밀번호",
                    text: $pwText,
                    supportText: "20글자 이내"
                )
                DodamTextField.editor(
                    title: "아이디",
                    text: $idText,
                    supportText: "20글자 이내"
                )
                .frame(height: 100)
                DodamTextField.default(
                    title: "비밀번호",
                    text: $pwText,
                    supportText: "20글자 이내",
                    isEnabled: false
                )
                DodamTextField.default(
                    title: "비밀번호",
                    text: $pwText,
                    supportText: "20글자 이내",
                    isError: true
                )
            }
            .padding()
            .registerPretendard()
        }
    }
    return DodamTextFieldPreview()
}
