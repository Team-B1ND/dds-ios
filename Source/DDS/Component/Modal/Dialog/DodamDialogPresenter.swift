import SwiftUI
import Combine

public struct DodamDialogPresenter<C: View>: ModalViewProtocol {
    
    public typealias P = DialogProvider
    @StateObject private var provider: DialogProvider
    
    let content: () -> C
    
    public init(
        provider: DialogProvider,
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
            modalContent: {
                VStack(spacing: 18) {
                    HStack {
                        VStack(alignment: .leading, spacing: 12) {
                            Text(provider.title)
                                .heading1(.bold)
                                .foreground(DodamColor.Label.strong)
                            if let message = provider.message {
                                Text(message)
                                    .body1(.medium)
                                    .foreground(DodamColor.Label.alternative)
                            }
                        }
                        Spacer()
                    }
                    .padding(6)
                    HStack(spacing: 8) {
                        if let secondaryButton = provider.secondaryButton {
                            if let primaryButton = provider.primaryButton {
                                DodamButton.fullWidth(title: secondaryButton.title) {
                                    secondaryButton.action()
                                    dismiss()
                                }
                                .role(.assistive)
                                DodamButton.fullWidth(title: primaryButton.title) {
                                    primaryButton.action()
                                    dismiss()
                                }
                            } else {
                                HStack {
                                    Spacer()
                                    DodamTextButton.large(title: secondaryButton.title) {
                                        secondaryButton.action()
                                        dismiss()
                                    }
                                }
                            }
                        } else {
                            HStack {
                                Spacer()
                                if let primaryButton = provider.primaryButton {
                                    DodamTextButton.large(title: primaryButton.title) {
                                        primaryButton.action()
                                        dismiss()
                                    }
                                } else {
                                    DodamTextButton.large(title: "닫기", color: DodamColor.Primary.normal) {
                                        dismiss()
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(18)
                .frame(width: 328)
            }, 
            content: content
        )
    }
}

#Preview {
    struct DialogPreview: View {
        @StateObject private var provider = DialogProvider()
        var body: some View {
            DodamDialogPresenter(provider: provider) {
                VStack {
                    Button("Show 1") {
                        provider.present("제목을 입력해주세요")
                            .message("본문을 입력해주세요")
                            .primaryButton("확인") {
                                //
                            }
                            .secondaryButton("취소") {
                                //
                            }
                            .show()
                    }
                    Button("Show 2") {
                        provider.present("제목을 입력해주세요")
                            .message("본문을 입력해주세요")
                            .show()
                    }
                }
            }
            .registerPretendard()
        }
    }
    return DialogPreview()
}
