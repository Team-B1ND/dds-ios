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
        secondaryButton: DialogButton? = nil,
        primaryButton: DialogButton? = nil
    ) {
        self.title = title
        self.message = message
        self.secondaryButton = secondaryButton
        self.primaryButton = primaryButton
    }
    
    public func secondaryButton(_ title: String, action: @escaping () -> Void) -> Self {
        .init(title: title, message: message, secondaryButton: .init(title, action: action), primaryButton: primaryButton)
    }
    
    public func primaryButton(_ title: String, action: @escaping () -> Void) -> Self {
        .init(title: title, message: message, secondaryButton: secondaryButton, primaryButton: .init(title, action: action))
    }
}
