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
    
    @Published var title: String = ""
    @Published var startDate: Date?
    @Published var endDate: Date?
    @Published var action: () -> Void = {}
    
    public init() {}
    
    public func present(
        _ title: String,
        startDate: Date?,
        endDate: Date?,
        action: @escaping () -> Void
    ) {
        self.date = .now
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.action = action
        self.isPresent = true
    }
}
