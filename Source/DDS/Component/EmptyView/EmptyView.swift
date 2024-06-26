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
                    .font(.label(.large))
                    .dodamColor(.onSurfaceVariant)
            }
            .padding(.top, 16)
            Button {
                action()
            } label: {
                Text(buttonTitle)
                    .font(.body(.large))
                    .dodamColor(.onSecondaryContainer)
                    .padding(.vertical, 14)
                    .frame(maxWidth: .infinity)
            }
            .background(Dodam.color(.secondaryContainer))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding([.horizontal, .bottom], 16)
        }
        .background(Dodam.color(.surfaceContainer))
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

#Preview {
    struct DodamContainerPreview: View {
        
        var body: some View {
            VStack(spacing: 20) {
                DodamEmptyView(
                    title: "아직 신청한 심야 자습이 없어요.",
                    icon: .fullMoonFace,
                    buttonTitle: "심야 자습 신청하기"
                ) { }
            }
            .padding(16)
            .background(Dodam.color(.surface))
            .registerSUIT()
        }
    }
    return DodamContainerPreview()
}
