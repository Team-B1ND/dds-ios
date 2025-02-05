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
    private let role: TextFieldRole
    private let isHide: Bool
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
        role: TextFieldRole,
        isHide: Bool,
        isEnabled: Bool,
        isError: Bool,
        isFirstResponder: Bool,
        colors: TextFieldColors
    ) {
        self._text = text
        self.font = font
        self.supportText = supportText
        self.role = role
        self.isHide = isHide
        self.isEnabled = isEnabled
        self.isError = isError
        self.isFirstResponder = isFirstResponder
        self.colors = colors
    }
    
    var body: some View {
        Group {
            switch (role, isHide) {
            case (.default, _), (.secured, false):
                TextField("", text: $text)
            case (.secured, true):
                SecureField("", text: $text)
            case (.editor, _):
                TextEditor(text: $text)
                    .padding(.horizontal, -4)
                    .padding(.vertical, 3)
                    .mask {
                        Rectangle()
                            .padding(.top, 10) // 위에 10만큼 자르기
                    }
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
