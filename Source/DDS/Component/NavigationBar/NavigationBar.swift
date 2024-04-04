import SwiftUI

@available(macOS 12, iOS 15, *)
public struct DodamNavigationBar: View {
    
    private let title: String
    private let font: Font
    private let icon: DodamIconography?
    private let verticalSpacing: CGFloat?
    private let showBackButton: Bool
    private let subView: AnyView?
    private let buttons: [DodamNavigationBarButton]
    
    private init(
        title: String = "",
        font: Font = .headline(.small),
        icon: DodamIconography? = nil,
        verticalSpacing: CGFloat? = nil,
        showBackButton: Bool = true,
        subView: AnyView? = nil,
        buttons: [DodamNavigationBarButton] = .init()
    ) {
        self.title = title
        self.font = font
        self.icon = icon
        self.verticalSpacing = verticalSpacing
        self.showBackButton = showBackButton
        self.subView = subView
        self.buttons = buttons
    }
    
    public static func `default`(title: String) -> Self {
        .init(
            title: title,
            showBackButton: false
        )
    }
    
    public static func icon(icon: DodamIconography) -> Self {
        .init(
            icon: icon,
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
    
    func subView<S: View>(
        @ViewBuilder content: @escaping () -> S
    ) -> Self {
        .init(
            title: self.title,
            font: self.font,
            icon: self.icon,
            verticalSpacing: self.verticalSpacing,
            showBackButton: self.showBackButton,
            subView: AnyView(content()),
            buttons: self.buttons
        )
    }
    
    public func button(
        icon: DodamIconography,
        action: @escaping () -> Void
    ) -> Self {
        .init(
            title: self.title,
            font: self.font,
            icon: self.icon,
            verticalSpacing: self.verticalSpacing,
            showBackButton: self.showBackButton,
            subView: self.subView,
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
        VStack(spacing: 0) {
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
                if let icon = icon {
                    Dodam.icon(icon)
                        .resizable()
                        .frame(width: 88, height: 22)
                        .dodamColor(.primary)
                        .padding(.leading, 16)
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
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
            }
            if let subView {
                subView
                    .padding(
                        .top,
                        verticalSpacing == nil ? 16 : 0
                    )
                    .padding([.horizontal, .bottom], 16)
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
        DodamNavigationBar.icon(icon: .logo)
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
    .registerSUIT()
}
