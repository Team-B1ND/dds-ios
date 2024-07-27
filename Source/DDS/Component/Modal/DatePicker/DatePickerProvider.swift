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
        _ datePicker: DatePicker
    ) {
        self.isPresent = true
        
        self.date = .now
        self.monthDate = .now
        
        self.datePicker = datePicker
    }
}
