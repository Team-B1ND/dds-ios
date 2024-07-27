//
//  File.swift
//  
//
//  Created by hhhello0507 on 7/27/24.
//

import Foundation

public struct TimePicker {
    let title: String
    let action: () -> Void
    
    public init(
        title: String,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.action = action
    }
}
