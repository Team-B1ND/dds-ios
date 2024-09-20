//
//  File.swift
//
//
//  Created by hhhello0507 on 8/21/24.
//

import Foundation

public struct TextFieldColors {
    // defaut
    public let hintColor: DodamColorable
    public let strokeColor: DodamColorable

    // unfocused
    public let foregroundColor: DodamColorable
    public let iconColor: DodamColorable

    // focused
    public let primaryColor: DodamColorable // for indicator color
    
    // error
    public let errorColor: DodamColorable
    
    public static let `default` = TextFieldColors(
        hintColor: DodamColor.Label.assistive,
        strokeColor: DodamColor.Line.normal,
        foregroundColor: DodamColor.Label.strong,
        iconColor: DodamColor.Label.alternative,
        primaryColor: DodamColor.Primary.normal,
        errorColor: DodamColor.Status.negative
    )
}
