import SwiftUI

@available(macOS 12, iOS 15, *)
public struct DodamNavigationView<C: View>: View {
    
    private let title: String
    private let font: Font
    private let verticalSpacing: CGFloat?
    private let content: () -> C
    
    private init(
        title: String,
        font: Font = .headline(.small),
        verticalSpacing: CGFloat? = nil,
        @ViewBuilder content: @escaping () -> C
    ) {
        self.title = title
        self.font = font
        self.verticalSpacing = verticalSpacing
        self.content = content
    }
    
    public static func `default`(
        title: String,
        @ViewBuilder content: @escaping () -> C
    ) -> Self {
        .init(
            title: title,
            content: content
        )
    }
    
    public static func small(
        title: String,
        @ViewBuilder content: @escaping () -> C
    ) -> Self {
        .init(
            title: title,
            font: .body(.large),
            content: content
        )
    }
    
    public static func medium(
        title: String,
        @ViewBuilder content: @escaping () -> C
    ) -> Self {
        .init(
            title: title,
            verticalSpacing: 1,
            content: content
        )
    }
    
    public static func large(
        title: String,
        @ViewBuilder content: @escaping () -> C
    ) -> Self {
        .init(
            title: title,
            font: .headline(.medium),
            verticalSpacing: 48,
            content: content
        )
    }
    
    private var text: Text {
        .init(title)
        .font(font)
    }
    
    public var body: some View {
        VStack {
            if let verticalSpacing {
                text
                    .padding(.top, verticalSpacing)
            }
            content()
        }
    }
}

#Preview {
    DodamNavigationView.large(title: "Hello") {
        Text("a")
    }
}
