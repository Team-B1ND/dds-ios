//
//  DodamModalProvider.swift
//
//
//  Created by hhhello0507 on 7/26/24.
//

import SwiftUI

public struct DodamModalProvider<C: View>: View {
    
    private let dialogProvider: DialogProvider
    private let content: () -> C
    
    public init(
        dialogProvider: DialogProvider,
        @ViewBuilder content: @escaping () -> C
    ) {
        self.dialogProvider = dialogProvider
        self.content = content
    }
    
    public var body: some View {
        DodamDialogPresenter(provider: dialogProvider) {
            content()
                .environmentObject(dialogProvider)
        }
    }
}
