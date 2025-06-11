//
//  Button+ButtonType.swift
//
//
//  Created by hhhello0507 on 7/26/24.
//

import SwiftUI

#if os(iOS)
extension DodamTextButton.TextButtonType {
    
    var font: Font {
        switch self {
        case .large: .body1(.bold)
        case .medium: .body2(.bold)
        case .small: .caption1(.bold)
        }
    }
    
    var verticalPadding: CGFloat {
        switch self {
        case .large: 8
        case .medium: 6
        case .small: 4
        }
    }
    
    var horizontalPadding: CGFloat {
        switch self {
        case .large: 12
        case .medium: 10
        case .small: 8
        }
    }
}
#endif
