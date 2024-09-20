//
//  File.swift
//
//
//  Created by hhhello0507 on 8/21/24.
//

import SwiftUI

internal struct BaseTextField: View {
    
    @FocusState private var focused
    @State private var animatedFocusing: Bool = false
    
    private var isHighlighted: Bool {
        animatedFocusing || !text.isEmpty
    }
    
    // MARK: - Parameters
    // text
    private let hint: String
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
        _ hint: String,
        text: Binding<String>,
        font: Font,
        supportText: String?,
        isSecured: Bool,
        isEnabled: Bool,
        isError: Bool,
        isFirstResponder: Bool,
        colors: TextFieldColors
    ) {
        self.hint = hint
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
        .overlay {
            Text(hint)
                .foreground(colors.hintColor)
                .scaleEffect(
                    isHighlighted ? 0.75 : 1,
                    anchor: .topLeading
                )
                .padding(.top, isHighlighted ? -30 : 0)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
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
            focused = true
        }
        .onChange(of: focused) { newValue in
            withAnimation(.spring(duration: 0.1)) {
                animatedFocusing = newValue
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
