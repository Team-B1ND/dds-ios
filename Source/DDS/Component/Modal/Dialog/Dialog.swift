//
//  File.swift
//  
//
//  Created by hhhello0507 on 7/27/24.
//

import Foundation

public struct Dialog {
    
    let title: String
    let message: String?
    let secondaryButton: DialogButton?
    let primaryButton: DialogButton?
    
    public init(
        title: String,
        message: String? = nil,
        primaryButton: DialogButton? = nil,
        secondaryButton: DialogButton? = nil
    ) {
        self.title = title
        self.message = message
        self.secondaryButton = secondaryButton
        self.primaryButton = primaryButton
    }
    
    public func secondaryButton(_ title: String, action: @escaping () -> Void) -> Self {
        .init(title: title, message: message, primaryButton: primaryButton, secondaryButton: .init(title, action: action))
    }
    
    public func primaryButton(_ title: String, action: @escaping () -> Void) -> Self {
        .init(title: title, message: message, primaryButton: .init(title, action: action), secondaryButton: secondaryButton)
    }
}
