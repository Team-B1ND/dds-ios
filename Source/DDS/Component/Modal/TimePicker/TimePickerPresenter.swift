import SwiftUI
import UIKit

public struct DodamTimePickerPresenter<C: View>: ModalViewProtocol {
    @StateObject private var provider: TimePickerProvider
    let content: () -> C
    
    init(
        provider: TimePickerProvider,
        @ViewBuilder content: @escaping () -> C
    ) {
        self._provider = .init(wrappedValue: provider)
        self.content = content
    }
    
    func dismiss() {
        provider.isPresent = false
    }
    
    public var body: some View {
        BaseModal(
            isPresent: $provider.isPresent,
            content: content
        ) {
            if let timePicker = provider.timePicker {
                VStack(spacing: 16) {
                    Text(timePicker.title)
                        .heading2(.bold)
                        .foreground(DodamColor.Label.strong)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    SwiftUI.DatePicker("", selection: $provider.date, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                        .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
                    HStack {
                        Spacer()
                        DodamTextButton.large(title: "선택", color: DodamColor.Primary.normal) {
                            timePicker.action()
                            dismiss()
                        }
                    }
                }
                .padding(24)
                .frame(width: 328)
                .clipShape(.extraLarge)
            }
        }
    }
}

private struct TimePickerPreview: View {
    @StateObject private var provider = TimePickerProvider()
    @State var date = Date.now
    var body: some View {
        DodamTimePickerPresenter(provider: provider) {
            VStack {
                Button("Show") {
                    provider.present(.init(title: "외출 일시") {
                        date = provider.date
                    })
                }
                Text("\(Calendar.current.dateComponents([.hour], from: date).hour!)")
                    .foreground(DodamColor.Label.normal)
                Text("\(Calendar.current.dateComponents([.minute], from: date).minute!)")
                    .foreground(DodamColor.Label.normal)
            }
        }
        .registerPretendard()
    }
}

#Preview {
    TimePickerPreview()
}

#Preview {
    TimePickerPreview()
        .preferredColorScheme(.dark)
}
