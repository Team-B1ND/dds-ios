import SwiftUI

@available(macOS 12, iOS 15, *)
public struct DodamTextField: View {
    
    @State private var isHide = true
    @FocusState private var focused
    
    // MARK: - parameters
    private let title: String
    @Binding private var text: String
    private let font: Font
    private let supportText: String?
    private let isSecured: Bool
    private let isEnabled: Bool
    private let isError: Bool
    private let isFirstResponder: Bool
    private let colors: TextFieldColors
    
    private init(
        title: String = "",
        text: Binding<String>,
        font: Font = .headline(.medium),
        supportText: String? = nil,
        isSecured: Bool = false,
        isEnabled: Bool = true,
        isError: Bool = false,
        isFirstResponder: Bool = false,
        colors: TextFieldColors = .default
    ) {
        self.title = title
        self._text = text
        self.font = font
        self.supportText = supportText
        self.isSecured = isSecured
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
            isSecured: false,
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
            isSecured: true,
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
            isSecured: isSecured,
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
                title,
                text: $text,
                font: font,
                supportText: supportText,
                isSecured: isSecured && isHide,
                isEnabled: isEnabled,
                isError: isError,
                isFirstResponder: isFirstResponder,
                colors: colors
            )
            TextFieldIcon(
                isHide: isHide,
                isSecured: isSecured,
                isEnabled: !text.isEmpty && focused,
                isError: isError,
                colors: colors
            ) {
                if isSecured {
                    isHide.toggle()
                } else {
                    text = ""
                }
            }
        }
        .frame(height: 43)
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
            if let supportText {
                Text(supportText)
                    .label(.medium)
                    .foreground(
                        isError
                        ? colors.errorColor
                        : colors.foregroundColor
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                    .offset(y: 24)
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
            VStack(spacing: 20) {
                DodamTextField.default(
                    title: "아이디",
                    text: $idText
                )
                DodamTextField.secured(
                    title: "비밀번호",
                    text: $pwText
                )
            }
            .padding()
            .registerPretendard()
        }
    }
    return DodamTextFieldPreview()
}
