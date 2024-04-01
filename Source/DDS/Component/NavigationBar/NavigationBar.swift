import SwiftUI

@available(macOS 12, iOS 15, *)
public struct DodamNavigationBar: View {
    
    private let title: String
    private let font: Font
    private let verticalSpacing: CGFloat?
    private let showBackButton: Bool
    private let buttons: [DodamNavigationBarButton]
    
    private init(
        title: String,
        font: Font = .headline(.small),
        verticalSpacing: CGFloat? = nil,
        showBackButton: Bool = true,
        buttons: [DodamNavigationBarButton] = .init()
    ) {
        self.title = title
        self.font = font
        self.verticalSpacing = verticalSpacing
        self.showBackButton = showBackButton
        self.buttons = buttons
    }
    
    public static func `default`(title: String) -> Self {
        .init(
            title: title,
            showBackButton: false
        )
    }
    
    public static func small(title: String) -> Self {
        .init(
            title: title,
            font: .body(.large)
        )
    }
    
    public static func medium(title: String) -> Self {
        .init(
            title: title,
            verticalSpacing: 1
        )
    }
    
    public static func large(title: String) -> Self {
        .init(
            title: title,
            font: .headline(.medium),
            verticalSpacing: 48
        )
    }
    
    public func button(
        icon: DodamIconography,
        action: @escaping () -> Void
    ) -> Self {
        .init(
            title: self.title,
            font: self.font,
            verticalSpacing: self.verticalSpacing,
            showBackButton: self.showBackButton,
            buttons: self.buttons + [
                .init(
                    icon: icon,
                    action: action
                )
            ]
        )
    }
    
    private var text: Text {
        .init(title)
        .font(font)
    }
    
    @Environment(\.dismiss) var dismiss
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                if showBackButton {
                    Button {
                        dismiss()
                    } label: {
                        Dodam.icon(.chevronLeft)
                            .resizable()
                            .frame(width: 24, height: 24)
                            .frame(width: 48, height: 48)
                    }
                    .dodamColor(.onSurface)
                }
                if verticalSpacing == nil {
                    text
                        .padding(
                            .leading,
                            showBackButton ? 4 : 16
                        )
                }
                Spacer()
                ForEach(buttons.indices, id: \.self) { idx in
                    let button = buttons[idx]
                    Button(action: button.action) {
                        Dodam.icon(button.icon)
                            .resizable()
                            .frame(width: 28, height: 28)
                            .frame(width: 48, height: 48)
                    }
                    .dodamColor(.onSurfaceVariant)
                }
            }
            .padding(.trailing, 4)
            .frame(height: 48)
            if let verticalSpacing {
                text
                    .padding([.horizontal, .bottom], 16)
                    .padding(.top, verticalSpacing)
            }
        }
    }
}

#Preview {
    VStack {
        Divider()
        DodamNavigationBar.default(title: "Default")
            .button(icon: .plus) { }
            .button(icon: .bell) { }
        Divider()
        DodamNavigationBar.small(title: "Small")
            .button(icon: .plus) { }
            .button(icon: .bell) { }
        Divider()
        DodamNavigationBar.medium(title: "Medium")
            .button(icon: .plus) { }
            .button(icon: .bell) { }
        Divider()
        DodamNavigationBar.large(title: "Large")
            .button(icon: .plus) { }
            .button(icon: .bell) { }
        Divider()
    }
}
