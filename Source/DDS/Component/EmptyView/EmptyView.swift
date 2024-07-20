import SwiftUI

@available(macOS 12, iOS 15, *)
public struct DodamEmptyView: View {
    
    private let title: String
    private let icon: DodamIconography
    private let buttonTitle: String
    private let action: () -> Void
    
    public init(
        title: String,
        icon: DodamIconography,
        buttonTitle: String,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.buttonTitle = buttonTitle
        self.action = action
    }
    
    public var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 12) {
                Dodam.icon(icon)
                    .frame(width: 36, height: 36)
                Text(title)
                    .font(.label(.medium))
                    .foreground(DodamColor.Label.alternative)
            }
            DodamButton.fullWidth(title: buttonTitle) {
                action()
            }
            .background(DodamColor.Fill.normal)
            .foreground(DodamColor.Label.normal)
        }
        .padding(16)
        .background(DodamColor.Background.normal)
        .clipShape(.large)
    }
}

private struct DodamContainerPreview: View {
    
    var body: some View {
        VStack(spacing: 20) {
            DodamEmptyView(
                title: "아직 신청한 심야 자습이 없어요.",
                icon: .fullMoonFace,
                buttonTitle: "심야 자습 신청하기"
            ) { }
        }
        .padding(16)
        .background(DodamColor.Background.neutral)
        .registerSUIT()
    }
}

#Preview {
    DodamContainerPreview()
}

#Preview {
    DodamContainerPreview()
        .preferredColorScheme(.dark)
}
