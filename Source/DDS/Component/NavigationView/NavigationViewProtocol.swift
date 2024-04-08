import SwiftUI

@available(macOS 12, iOS 15, *)
public protocol DodamNavigationViewProtocol: View {
    
    associatedtype C: View
    
    var navigationBar: DodamNavigationBar { get }
    var buttons: [DodamNavigationBarButton] { get }
    var subView: AnyView? { get }
    var content: () -> C { get }
    
    static func makeView(
        borderSize: CGFloat?,
        navigationBar: DodamNavigationBar,
        buttons: [DodamNavigationBarButton],
        subView: AnyView?,
        @ViewBuilder content: @escaping () -> C
    ) -> Self
}

public extension DodamNavigationViewProtocol {
    
    static func makeView(
        borderSize: CGFloat? = nil,
        navigationBar: DodamNavigationBar,
        buttons: [DodamNavigationBarButton] = .init(),
        subView: AnyView? = nil,
        @ViewBuilder content: @escaping () -> C
    ) -> Self {
        makeView(
            borderSize: borderSize,
            navigationBar: navigationBar,
            buttons: buttons,
            subView: subView,
            content: content
        )
    }
    
    static func `default`(
        title: String,
        @ViewBuilder content: @escaping () -> C
    ) -> Self {
        makeView(
            navigationBar: .default(title: title),
            content: content
        )
    }
    
    static func icon(
        icon: DodamIconography,
        @ViewBuilder content: @escaping () -> C
    ) -> Self {
        makeView(
            navigationBar: .icon(icon: icon),
            content: content
        )
    }
    
    static func small(
        title: String,
        @ViewBuilder content: @escaping () -> C
    ) -> Self {
        makeView(
            navigationBar: .small(title: title),
            content: content
        )
    }
    
    static func medium(
        title: String,
        @ViewBuilder content: @escaping () -> C
    ) -> Self {
        makeView(
            navigationBar: .medium(title: title),
            content: content
        )
    }
    
    static func large(
        title: String,
        @ViewBuilder content: @escaping () -> C
    ) -> Self {
        makeView(
            navigationBar: .large(title: title),
            content: content
        )
    }
    
    func subView<S: View>(
        @ViewBuilder content: @escaping () -> S
    ) -> Self {
        Self.makeView(
            navigationBar: self.navigationBar,
            buttons: self.buttons,
            subView: AnyView(content()),
            content: self.content
        )
    }
    
    func button(
        icon: DodamIconography,
        hidden: Bool = false,
        action: @escaping () -> Void
    ) -> Self {
        guard !hidden else { return self }
        return Self.makeView(
            navigationBar: self.navigationBar,
            buttons: self.buttons + [
                .init(
                    icon: icon,
                    action: action
                )
            ],
            subView: self.subView,
            content: self.content
        )
    }
    
    func applyBar(
        bar: DodamNavigationBar,
        index: Int = 0
    ) -> DodamNavigationBar {
        if !buttons.isEmpty {
            let item = buttons[index]
            let result = bar
                .button(icon: item.icon, action: item.action)
            if buttons.count != index + 1 {
                return applyBar(
                    bar: result,
                    index: index + 1
                )
            } else {
                return result
                    .subView { subView }
            }
        } else {
            return bar
                .subView { subView }
        }
    }
}
