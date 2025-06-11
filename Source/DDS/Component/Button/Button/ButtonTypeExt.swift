//
//  Button+ButtonType.swift
//  
//
//  Created by hhhello0507 on 7/26/24.
//

import SwiftUI

#if os(iOS)
extension DodamButton.ButtonType {
    var shape: DodamShape {
        switch self {
        case .large: .medium
        case .medium: .small
        case .small: .extraSmall
        }
    }
    
    var height: CGFloat {
        switch self {
        case .large: 48
        case .medium: 38
        case .small: 32
        }
    }
    
    var horizontalPadding: CGFloat {
        switch self {
        case .large: 28
        case .medium: 20
        case .small: 12
        }
    }
    
    var iconSize: CGFloat {
        switch self {
        case .large: 20
        case .medium: 18
        case .small: 16
        }
    }
    
    var font: Font {
        switch self {
        case .large: .body1(.bold)
        case .medium: .body2(.bold)
        case .small: .caption1(.bold)
        }
    }
    
    var horizontalSpacing: CGFloat {
        switch self {
        case .large: 6
        case .medium: 5
        case .small: 4
        }
    }
}
#endif
