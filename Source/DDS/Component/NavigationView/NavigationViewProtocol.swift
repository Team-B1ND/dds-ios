import SwiftUI

@available(macOS 12, iOS 15, *)
protocol NavigationViewProtocol: View {
    
    associatedtype C: View
    
    var navigationBar: DodamNavigationBar { get }
    var buttons: [DodamNavigationBarButton] { get }
    var content: () -> C { get }
    
    init(
        navigationBar: DodamNavigationBar,
        buttons: [DodamNavigationBarButton],
        @ViewBuilder content: @escaping () -> C
    )
}

extension NavigationViewProtocol {
    
    static func `default`(
        title: String,
        @ViewBuilder content: @escaping () -> C
    ) -> Self {
        .init(
            navigationBar: .default(title: title),
            buttons: [],
            content: content
        )
    }
    
    static func small(
        title: String,
        @ViewBuilder content: @escaping () -> C
    ) -> Self {
        .init(
            navigationBar: .small(title: title),
            buttons: [],
            content: content
        )
    }
    
    static func medium(
        title: String,
        @ViewBuilder content: @escaping () -> C
    ) -> Self {
        .init(
            navigationBar: .medium(title: title),
            buttons: [],
            content: content
        )
    }
    
    static func large(
        title: String,
        @ViewBuilder content: @escaping () -> C
    ) -> Self {
        .init(
            navigationBar: .large(title: title),
            buttons: [],
            content: content
        )
    }
    
    func button(
        icon: DodamIconography,
        action: @escaping () -> Void
    ) -> Self {
        .init(
            navigationBar: self.navigationBar,
            buttons: self.buttons + [
                .init(
                    icon: icon,
                    action: action
                )
            ],
            content: self.content
        )
    }
    
    func applyButton(
        bar: DodamNavigationBar,
        index: Int = 0
    ) -> DodamNavigationBar {
        if !buttons.isEmpty {
            let item = buttons[index]
            let result = bar
                .button(icon: item.icon, action: item.action)
            if buttons.count != index + 1 {
                return applyButton(
                    bar: result,
                    index: index + 1
                )
            } else {
                return result
            }
        } else {
            return bar
        }
    }
}
