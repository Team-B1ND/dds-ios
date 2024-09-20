//
//  File.swift
//
//
//  Created by hhhello0507 on 8/21/24.
//

import SwiftUI

internal struct TextFieldIcon: View {
    
    let isHide: Bool
    let isSecured: Bool
    let isEnabled: Bool
    let isError: Bool
    let colors: TextFieldColors
    let action: () -> Void
    
    var body: some View {
        Button {
            if isEnabled {
                action()
            }
        } label: {
            Image(
                icon: isError
                ? .exclamationmarkCircle
                : isSecured
                ? isHide ? .eyeSlash : .eye
                : .xmarkCircle
            )
            .resizable()
            .renderingMode(.template)
            .foreground(
                isError
                ? colors.errorColor
                : colors.iconColor
            )
            .frame(width: 24, height: 24)
            .padding(4)
            .opacity(
                isError
                ? 1
                : isEnabled
                ? 0.5
                : 0
            )
        }
    }
}
