import SwiftUI

@available(macOS 12, iOS 15, *)
public struct DodamTextField: View {
    
    private let title: String
    private let isSecured: Bool
    private let isFirstResponder: Bool
    @Binding private var text: String
    
    private init(
        title: String,
        isSecured: Bool,
        isFirstResponder: Bool = false,
        text: Binding<String>
    ) {
        self.title = title
        self.isSecured = isSecured
        self.isFirstResponder = isFirstResponder
        self._text = text
    }
    
    public func makeFirstResponder() -> Self {
        .init(title: title,
              isSecured: isSecured,
              isFirstResponder: true,
              text: $text)
    }
    
    public static func `default`(
        title: String,
        text: Binding<String>
    ) -> Self {
        .init(
            title: title,
            isSecured: false,
            text: text
        )
    }
    
    public static func secured(
        title: String,
        text: Binding<String>
    ) -> Self {
        .init(
            title: title,
            isSecured: true,
            text: text
        )
    }
    
    @FocusState private var isFocused: Bool
    @State private var animatedFocusing: Bool = false
    
    private var isHighlighted: Bool {
        animatedFocusing || !text.isEmpty
    }
      
    public var body: some View {
        VStack(spacing: 12) {
            ZStack(alignment: .leading) {
                Text(title)
                    .scaleEffect(
                        isHighlighted ? 0.75 : 1,
                        anchor: .topLeading
                    )
                    .padding(.top, isHighlighted ? -30 : 0)
                HStack {
                    Group {
                        if isSecured {
                            SecureField("", text: $text)
                        } else {
                            TextField("", text: $text)
                        }
                    }
                    .focused($isFocused)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .foregroundStyle(Color(.label))
                    if isFocused && !text.isEmpty {
                        Button {
                            text = ""
                        } label: {
                            Dodam.icon(.xmarkCircle)
                        }
                        .foreground(DodamColor.Label.assistive)
                        .padding(.vertical, -2)
                    }
                }
            }
            .frame(height: 41, alignment: .bottomLeading)
            .body1(.medium)
            Rectangle()
                .frame(height: 1)
        }
        .foreground(isFocused ? DodamColor.Primary.normal : DodamColor.Label.alternative)
        .onChange(of: isFocused) { newValue in
            withAnimation(.spring(duration: 0.1)) {
                animatedFocusing = newValue
            }
        }
        .onAppear {
            if isFirstResponder {
                isFocused = true
            }
        }
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
            .registerSUIT()
        }
    }
    return DodamTextFieldPreview()
}
