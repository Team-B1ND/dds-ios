//
//  File.swift
//  
//
//  Created by hhhello0507 on 7/27/24.
//

import Foundation

public struct DatePicker {
    
    let title: String
    let startDate: Date
    let endDate: Date
    let action: () -> Void
    
    public init(
        title: String,
        startDate: Date,
        endDate: Date,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.action = action
    }
}
