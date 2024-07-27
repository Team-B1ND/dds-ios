import SwiftUI
import Combine

public struct DodamDialogPresenter<C: View>: ModalViewProtocol {
    
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
            content: content
        ) {
            if let dialog = provider.dialog {
                VStack(spacing: 18) {
                    HStack {
                        VStack(alignment: .leading, spacing: 12) {
                            Text(dialog.title)
                                .heading1(.bold)
                                .foreground(DodamColor.Label.strong)
                            if let message = dialog.message {
                                Text(message)
                                    .body1(.medium)
                                    .foreground(DodamColor.Label.alternative)
                            }
                        }
                        Spacer()
                    }
                    .padding(6)
                    HStack(spacing: 8) {
                        if let secondaryButton = dialog.secondaryButton {
                            if let primaryButton = dialog.primaryButton {
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
                                if let primaryButton = dialog.primaryButton {
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
            }
        }
    }
}

#Preview {
    struct DialogPreview: View {
        @StateObject private var provider = DialogProvider()
        var body: some View {
            DodamDialogPresenter(provider: provider) {
                VStack {
                    Button("Show 1") {
                        provider.present(
                            .init(
                                title: "제목을 입력해주세요",
                                message: "본문을 입력해주세요",
                                secondaryButton: .init("확인") {
                                    
                                },
                                primaryButton: .init("취소") {
                                    
                                }
                            )
                        )
                    }
                    Button("Show 2") {
                        provider.present(
                            .init(
                                title: "제목을 입력해주세요",
                                message: "본문을 입력해주세요"
                            )
                        )
                    }
                    Button("Show 3") {
                        provider.present(
                            .init(title: "와우")
                            .primaryButton("Hello") {
                                print("WOW")
                            }
                        )
                    }
                }
            }
            .registerPretendard()
        }
    }
    return DialogPreview()
}
