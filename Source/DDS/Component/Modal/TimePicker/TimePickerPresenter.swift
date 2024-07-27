import SwiftUI

public struct DodamTimePickerPresenter<C: View>: ModalViewProtocol {
    
    public typealias P = TimePickerProvider
    @StateObject private var provider: TimePickerProvider
    @State private var size: CGSize = .zero
    let content: () -> C
    
    private let hours = Array(0..<24)
    private let minutes = Array(0..<60)
    
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
            VStack(spacing: 16) {
                Text(provider.title)
                    .heading2(.bold)
                    .foreground(DodamColor.Label.strong)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack(spacing: 0) {
                    SnapScrollView(
                        Array(hours.enumerated()),
                        selection: $provider.hour,
                        spacing: 12,
                        showItemCount: 5
                    ) { idx, item in
                        let selected = idx == provider.hour
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
                        selection: $provider.minute,
                        spacing: 12,
                        showItemCount: 5
                    ) { idx, item in
                        let selected = idx == provider.minute
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
                        provider.action()
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

private struct TimePickerPreview: View {
    @StateObject private var provider = TimePickerProvider()
    @State var hour = 0
    @State var minute = 0
    var body: some View {
        DodamTimePickerPresenter(provider: provider) {
            VStack {
                Button("Show") {
                    provider.present("외출 일시") {
                        print("Hello")
                    }
                }
                Text("\(hour)")
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
