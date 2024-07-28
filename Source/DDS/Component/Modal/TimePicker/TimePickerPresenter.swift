import SwiftUI

public struct DodamTimePickerPresenter<C: View>: ModalViewProtocol {
    
    private let calendar = {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ko-KR")
        return calendar
    }()
    private let hours = Array(0..<24)
    private let minutes = Array(0..<60)
    
    @StateObject private var provider: TimePickerProvider
    @State private var size: CGSize = .zero
    let content: () -> C
    
    init(
        provider: TimePickerProvider,
        @ViewBuilder content: @escaping () -> C
    ) {
        self._provider = .init(wrappedValue: provider)
        self.content = content
    }
    
    private var hour: Int? {
        components.hour
    }
    
    private var minute: Int? {
        components.minute
    }
    
    private var components: DateComponents {
        calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: provider.date)
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
                    HStack(spacing: 0) {
                        SnapScrollView(
                            Array(hours.enumerated()),
                            selection: .init {
                                hour ?? 0
                            } set: { hour in
                                var components = components
                                components.hour = hour
                                if let date = calendar.date(from: components) {
                                    provider.date = date
                                }
                            },
                            spacing: 12,
                            showItemCount: 5
                        ) { idx, item in
                            let selected = idx == hour
                            Text("\(item)")
                                .title3(.medium)
                                .foreground(
                                    selected
                                    ? DodamColor.Label.normal
                                    : DodamColor.Label.alternative
                                )
                                .opacity(selected ? 1 : 0.5)
                                .padding(.horizontal, 20)
                        }
                        Text(":")
                            .heading1(.bold)
                            .foreground(DodamColor.Label.normal)
                        SnapScrollView(
                            Array(minutes.enumerated()),
                            selection: .init {
                                minute ?? 0
                            } set: { minute in
                                var components = components
                                components.minute = minute
                                if let date = calendar.date(from: components) {
                                    provider.date = date
                                }
                            },
                            spacing: 12,
                            showItemCount: 5
                        ) { idx, item in
                            let selected = idx == minute
                            Text("\(item)")
                                .title3(.medium)
                                .foreground(
                                    selected
                                    ? DodamColor.Label.normal
                                    : DodamColor.Label.alternative
                                )
                                .opacity(selected ? 1 : 0.5)
                                .padding(.horizontal, 20)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .background {
                        Rectangle()
                            .dodamFill(DodamColor.Fill.alternative)
                            .opacity(0.5)
                            .frame(height: 44)
                            .clipShape(.small)
                    }
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
