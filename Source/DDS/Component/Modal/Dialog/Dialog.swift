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
    
    public func message(_ message: String? = nil) -> Self {
        .init(title: self.title, message: message, primaryButton: self.primaryButton, secondaryButton: self.secondaryButton)
    }
    
    public func secondaryButton(_ title: String, action: @escaping () -> Void = {}) -> Self {
        .init(title: self.title, message: self.message, primaryButton: self.primaryButton, secondaryButton: .init(title, action: action))
    }
    
    public func primaryButton(_ title: String, action: @escaping () -> Void = {}) -> Self {
        .init(title: self.title, message: self.message, primaryButton: .init(title, action: action), secondaryButton: self.secondaryButton)
    }
}
