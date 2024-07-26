import SwiftUI


@available(macOS 12, iOS 15, *)
public struct DodamTextButton: View {
    
    public enum TextButtonType {
        case large
        case medium
        case small
    }
    
    public typealias AsyncAction = () async -> Void
    
    private let type: TextButtonType
    private let title: String
    private let color: DodamColorable
    private let action: AsyncAction
    private let isDisabled: Bool
    
    private init(
        type: TextButtonType,
        title: String,
        color: DodamColorable,
        action: @escaping AsyncAction,
        isDisabled: Bool = false
    ) {
        self.type = type
        self.title = title
        self.color = color
        self.action = action
        self.isDisabled = isDisabled
    }
    
    public static func large(
        title: String,
        color: DodamColorable = DodamColor.Label.strong,
        action: @escaping AsyncAction
    ) -> Self {
        .init(
            type: .large,
            title: title,
            color: color,
            action: action
        )
    }
    
    public static func medium(
        title: String,
        color: DodamColorable = DodamColor.Label.strong,
        action: @escaping AsyncAction
    ) -> Self {
        .init(
            type: .medium,
            title: title,
            color: color,
            action: action
        )
    }
    
    public static func small(
        title: String,
        color: DodamColorable = DodamColor.Label.strong,
        action: @escaping AsyncAction
    ) -> Self {
        .init(
            type: .small,
            title: title,
            color: color,
            action: action
        )
    }
    
    public func disabled(_ condition: Bool = true) -> Self {
        .init(
            type: self.type,
            title: self.title,
            color: self.color,
            action: self.action,
            isDisabled: condition
        )
    }
    
    @State private var isPerformingTask: Bool = false
    
    private var isTranslucent: Bool {
        isDisabled || isPerformingTask
    }
    
    public var body: some View {
        Button {
            withAnimation(.none) {
                isPerformingTask = true
            }
            Task {
                await action()
                isPerformingTask = false
            }
        } label: {
            Text(title)
                .font(type.font)
                .opacity(isPerformingTask ? 0 : 1)
                .padding(.horizontal, type.horizontalPadding)
                .padding(.vertical, type.verticalPadding)
                .foreground(color)
        }
        .disabled(isTranslucent)
        .opacity(isTranslucent ? 0.5 : 1)
        .background {
            if isPerformingTask {
                DodamLoadingView()
            }
        }
    }
}

private struct ButtonPreview: View {
    
    func makePreview(role: DodamButton.ButtonRole) -> some View {
        let title = "Button"
        let action: () async -> Void = {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
        }
        return VStack(alignment: .leading) {
            DodamTextButton.large(
                title: title,
                action: action
            )
            DodamTextButton.large(
                title: title,
                action: action
            )
            .disabled()
            DodamTextButton.medium(
                title: title,
                action: action
            )
            DodamTextButton.medium(
                title: title,
                action: action
            )
            .disabled()
            DodamTextButton.small(
                title: title,
                action: action
            )
            DodamTextButton.small(
                title: title,
                action: action
            )
            .disabled()
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                makePreview(role: .primary)
                makePreview(role: .secondary)
                makePreview(role: .assistive)
            }
        }
        .padding()
        .registerPretendard()
    }
}

#Preview {
    ButtonPreview()
}

#Preview {
    ButtonPreview()
        .preferredColorScheme(.dark)
}
