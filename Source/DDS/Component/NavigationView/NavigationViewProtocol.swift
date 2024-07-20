import SwiftUI

@available(macOS 12, iOS 15, *)
public protocol DodamNavigationViewProtocol: View {
    
    associatedtype C: View
    
    var topAppBar: DodamTopAppBar { get }
    var buttons: [DodamTopAppBarButton] { get }
    var subView: AnyView? { get }
    var content: () -> C { get }
    
    static func makeView(
        borderSize: CGFloat?,
        topAppBar: DodamTopAppBar,
        buttons: [DodamTopAppBarButton],
        subView: AnyView?,
        @ViewBuilder content: @escaping () -> C
    ) -> Self
}

public extension DodamNavigationViewProtocol {
    
    static func makeView(
        borderSize: CGFloat? = nil,
        topAppBar: DodamTopAppBar,
        buttons: [DodamTopAppBarButton] = [],
        subView: AnyView? = nil,
        @ViewBuilder content: @escaping () -> C
    ) -> Self {
        makeView(
            borderSize: borderSize,
            topAppBar: topAppBar,
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
            topAppBar: .default(title: title),
            content: content
        )
    }
    
    static func icon(
        icon: DodamIconography,
        @ViewBuilder content: @escaping () -> C
    ) -> Self {
        makeView(
            topAppBar: .icon(icon: icon),
            content: content
        )
    }
    
    static func small(
        title: String,
        @ViewBuilder content: @escaping () -> C
    ) -> Self {
        makeView(
            topAppBar: .small(title: title),
            content: content
        )
    }
    
    static func medium(
        title: String,
        @ViewBuilder content: @escaping () -> C
    ) -> Self {
        makeView(
            topAppBar: .medium(title: title),
            content: content
        )
    }
    
    static func large(
        title: String,
        @ViewBuilder content: @escaping () -> C
    ) -> Self {
        makeView(
            topAppBar: .large(title: title),
            content: content
        )
    }
    
    func subView<S: View>(
        @ViewBuilder content: @escaping () -> S
    ) -> Self {
        Self.makeView(
            topAppBar: self.topAppBar,
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
            topAppBar: self.topAppBar,
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
        bar: DodamTopAppBar,
        index: Int = 0
    ) -> DodamTopAppBar {
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
