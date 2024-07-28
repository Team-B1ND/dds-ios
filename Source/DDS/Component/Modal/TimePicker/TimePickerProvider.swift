//
//  TimePickerProvider.swift
//
//
//  Created by hhhello0507 on 7/27/24.
//

import Foundation
import SwiftUI

public final class TimePickerProvider: ModalProvider {
    @Published var isPresent: Bool = false
    
    @Published public var date: Date = .now
    
    @Published var timePicker: TimePicker?
    
    public init() {}
    
    public func present(
        _ timePicker: TimePicker,
        date: Date = .now
    ) {
        self.isPresent = true
        
        self.date = date
        
        self.timePicker = timePicker
    }
}
