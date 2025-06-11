//
//  File.swift
//
//
//  Created by hhhello0507 on 8/21/24.
//

import SwiftUI

#if os(iOS)
internal struct TextFieldIcon: View {
    
    let isHide: Bool
    let role: TextFieldRole
    let isEnabled: Bool
    let isError: Bool
    let colors: TextFieldColors
    let action: () -> Void
    
    var icon: DodamIconography {
        if isError {
            .exclamationmarkCircle
        } else if role == .secured {
            isHide ? .eyeSlash : .eye
        } else {
            .xmarkCircle
        }
    }
    
    var body: some View {
        if role != .editor {
            Button {
                if isEnabled {
                    action()
                }
            } label: {
                Image(icon: icon)
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
}
#endif
