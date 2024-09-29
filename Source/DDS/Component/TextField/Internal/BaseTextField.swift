//
//  File.swift
//
//
//  Created by hhhello0507 on 8/21/24.
//

import SwiftUI

internal struct BaseTextField: View {
    
    @FocusState private var focused
    
    // MARK: - Parameters
    // text
    @Binding private var text: String
    private let font: Font
    private let supportText: String?
    
    // state
    private let isSecured: Bool
    private let isEnabled: Bool
    private let isError: Bool
    
    // interaction
    private let isFirstResponder: Bool
    
    // style
    private let colors: TextFieldColors
    
    init(
        text: Binding<String>,
        font: Font,
        supportText: String?,
        isSecured: Bool,
        isEnabled: Bool,
        isError: Bool,
        isFirstResponder: Bool,
        colors: TextFieldColors
    ) {
        self._text = text
        self.font = font
        self.supportText = supportText
        self.isSecured = isSecured
        self.isEnabled = isEnabled
        self.isError = isError
        self.isFirstResponder = isFirstResponder
        self.colors = colors
    }
    
    var body: some View {
        Group {
            if isSecured {
                SecureField("", text: $text)
            } else {
                TextField("", text: $text)
            }
        }
        .focused($focused)
        // style
        .font(font)
        .foreground(colors.foregroundColor)
        .tint(
            isError
            ? colors.errorColor
            : colors.primaryColor
        )
        // interaction
        .disabled(!isEnabled)
        .onAppear {
            if isFirstResponder {
                focused = true
            }
        }
        // optimization
#if canImport(UIKit)
        .textInputAutocapitalization(.never)
#endif
        .autocorrectionDisabled()
        .textContentType(.init(rawValue: ""))
    }
}
