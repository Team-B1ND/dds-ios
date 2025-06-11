//
//  DodamModalProvider.swift
//
//
//  Created by hhhello0507 on 7/26/24.
//

import SwiftUI

#if os(iOS)
public struct DodamModalProvider<C: View>: View {
    
    private let dialogProvider: DialogProvider
    private let datePickerProvider: DatePickerProvider
    private let timePickerProvider: TimePickerProvider
    private let content: () -> C
    
    public init(
        dialogProvider: DialogProvider,
        datePickerProvider: DatePickerProvider,
        timePickerProvider: TimePickerProvider,
        @ViewBuilder content: @escaping () -> C
    ) {
        self.dialogProvider = dialogProvider
        self.datePickerProvider = datePickerProvider
        self.timePickerProvider = timePickerProvider
        self.content = content
    }
    
    public var body: some View {
        DodamDialogPresenter(provider: dialogProvider) {
            DodamDatePickerPresenter(provider: datePickerProvider) {
                DodamTimePickerPresenter(provider: timePickerProvider) {
                    content()
                        .environmentObject(dialogProvider)
                        .environmentObject(datePickerProvider)
                        .environmentObject(timePickerProvider)
                }
            }
        }
    }
}

#endif
