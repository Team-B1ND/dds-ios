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
    
    @Published var title: String = ""
    @Published var hour: Int = 0
    @Published var minute: Int = 0
    @Published var action: () -> Void = {}
    
    func present(
        _ title: String,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.hour = 0
        self.minute = 0
        self.action = action
        self.isPresent = true
    }
}
