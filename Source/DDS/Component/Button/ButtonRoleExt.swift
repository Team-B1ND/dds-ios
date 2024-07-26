//
//  Button+ButtonRole.swift
//
//
//  Created by hhhello0507 on 7/26/24.
//

import SwiftUI

extension DodamButton.ButtonRole {
    var background: DodamColorable {
        switch self {
        case .primary: DodamColor.Primary.normal
        case .secondary: DodamColor.Primary.assistive
        case .assistive: DodamColor.Fill.normal
        }
    }
    
    var foreground: DodamColorable {
        switch self {
        case .primary: DodamColor.Static.white
        case .secondary: DodamColor.Primary.normal
        case .assistive: DodamColor.Label.neutral
        }
    }
}
