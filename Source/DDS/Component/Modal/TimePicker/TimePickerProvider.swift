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
    
    @Published public var hour: Int = 0
    @Published public var minute: Int = 0
    
    @Published var timePicker: TimePicker?
    
    public init() {}
    
    public func present(
        _ timePicker: TimePicker
    ) {
        self.isPresent = true
        
        self.hour = 0
        self.minute = 0
        
        self.timePicker = timePicker
    }
}
