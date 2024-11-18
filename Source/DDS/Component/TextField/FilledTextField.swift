//
//  File.swift
//
//
//  Created by hhhello0507 on 8/22/24.
//

import SwiftUI

public struct DodamFilledTextField: View {
    
    @State private var isHide = false
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
        title: String,
        text: Binding<String>,
        font: Font,
        supportText: String?,
        isSecured: Bool,
        isEnabled: Bool,
        isError: Bool,
        isFirstResponder: Bool,
        colors: TextFieldColors
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
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Label")
                .label(.medium)
                .foreground(
                    isError
                    ? colors.errorColor
                    : focused
                    ? colors.primaryColor
                    : colors.hintColor
                )
            HStack(spacing: 0) {
                BaseTextField(
                    text: $text,
                    font: font,
                    supportText: supportText,
                    isSecured: isSecured && isHide,
                    isEnabled: isEnabled,
                    isError: isError,
                    isFirstResponder: isFirstResponder,
                    colors: .default
                )
                TextFieldIcon(
                    isHide: isHide,
                    isSecured: isSecured,
                    isEnabled: !text.isEmpty,
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
            .padding(.leading, 16)
            .padding(.trailing, 12)
            .frame(height: 48)
            .padding(.vertical, 4)
            .background(DodamColor.Background.normal)
            .overlay {
                if isError {
                    Dodam.color(DodamColor.Status.negative)
                        .opacity(0.03)
                } else if focused {
                    Dodam.color(DodamColor.Primary.normal)
                        .opacity(0.03)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .dodamStroke(
                        isError
                        ? colors.errorColor
                        : focused
                        ? colors.primaryColor
                        : colors.strokeColor,
                        lineWidth: 1
                    )
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
                        .offset(y: 20)
                }
            }
            .focused($focused)
            .advancedFocus()
            .opacity(isEnabled ? 1 : 0.5)
        }
    }
}

private struct TextFieldPreview: View {
    @State private var text = ""
    var body: some View {
        VStack(spacing: 40) {
            DodamFilledTextField.default(
                title: "Label",
                text: $text,
                supportText: "Support Text"
            )
            DodamFilledTextField.secured(
                title: "Label",
                text: $text,
                supportText: "Support Text"
            )
            DodamFilledTextField.default(
                title: "Label",
                text: $text,
                supportText: "Support Text",
                isEnabled: false
            )
            DodamFilledTextField.default(
                title: "Label",
                text: $text,
                supportText: "Support Text",
                isError: true
            )
        }
        .padding(.horizontal, 15)
        .registerPretendard()
    }
}

#Preview {
    TextFieldPreview()
}

#Preview {
    TextFieldPreview()
        .preferredColorScheme(.dark)
}