//
//  File.swift
//  
//
//  Created by hhhello0507 on 7/27/24.
//

import Foundation

public final class DatePickerProvider: ModalProvider {
    @Published var isPresent = false
    
    @Published public var date: Date = .now
    @Published public var monthDate: Date = .now
    
    @Published var datePicker: DatePicker?
    
    public init() {}
    
    public func present(
        _ datePicker: DatePicker,
        date: Date = .now,
        monthDate: Date = .now
    ) {
        self.isPresent = true
        
        self.date = date
        self.monthDate = monthDate
        
        self.datePicker = datePicker
    }
}
