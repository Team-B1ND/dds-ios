import SwiftUI


@available(macOS 12, iOS 15, *)
public struct DodamButton: View {
    
    public enum ButtonType {
        case large
        case medium
        case small
    }
    
    public enum ButtonRole {
        case primary
        case secondary
        case assistive
    }
    
    public typealias AsyncAction = () async -> Void
    
    private let type: ButtonType
    private let title: String
    private let leadingIcon: Image?
    private let trailingIcon: Image?
    private let action: AsyncAction
    private let isDisabled: Bool
    private let role: ButtonRole
    
    private init(
        type: ButtonType,
        title: String,
        leadingIcon: Image?,
        trailingIcon: Image?,
        action: @escaping AsyncAction,
        isDisabled: Bool = false,
        role: ButtonRole = .primary
    ) {
        self.type = type
        self.title = title
        self.leadingIcon = leadingIcon
        self.trailingIcon = trailingIcon
        self.action = action
        self.isDisabled = isDisabled
        self.role = role
    }
    
    public static func fullWidth(
        title: String,
        leadingIcon: Image? = nil,
        trailingIcon: Image? = nil,
        action: @escaping AsyncAction
    ) -> Self {
        .init(
            type: .large,
            title: title,
            leadingIcon: leadingIcon,
            trailingIcon: trailingIcon,
            action: action
        )
    }
    
    public static func medium(
        title: String,
        leadingIcon: Image? = nil,
        trailingIcon: Image? = nil,
        action: @escaping AsyncAction
    ) -> Self {
        .init(
            type: .medium,
            title: title,
            leadingIcon: leadingIcon,
            trailingIcon: trailingIcon,
            action: action
        )
    }
    
    public static func small(
        title: String,
        leadingIcon: Image? = nil,
        trailingIcon: Image? = nil,
        action: @escaping AsyncAction
    ) -> Self {
        .init(
            type: .small,
            title: title,
            leadingIcon: leadingIcon,
            trailingIcon: trailingIcon,
            action: action
        )
    }
    
    public func disabled(_ condition: Bool = true) -> Self {
        .init(
            type: self.type,
            title: self.title,
            leadingIcon: self.leadingIcon,
            trailingIcon: self.trailingIcon,
            action: self.action,
            isDisabled: condition,
            role: self.role
        )
    }
    
    public func role(_ role: ButtonRole) -> Self {
        .init(
            type: self.type,
            title: self.title,
            leadingIcon: self.leadingIcon,
            trailingIcon: self.trailingIcon,
            action: self.action,
            isDisabled: self.isDisabled,
            role: role
        )
    }
    
    @State private var isPerformingTask: Bool = false
    
    private var maxWidth: CGFloat? {
        guard type != .large else { return .infinity }
        return nil
    }
    
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
            HStack(spacing: type.horizontalSpacing) {
                if let leadingIcon {
                    leadingIcon
                        .resizable()
                        .scaledToFit()
                        .frame(width: type.iconSize,height: type.iconSize)
                }
                Text(title)
                    .font(type.font)
                if let trailingIcon {
                    trailingIcon
                        .resizable()
                        .scaledToFit()
                        .frame(width: type.iconSize,height: type.iconSize)
                }
            }
            .opacity(isPerformingTask ? 0 : 1)
            .frame(height: type.height)
            .padding(.horizontal, type.horizontalPadding)
            .frame(maxWidth: maxWidth)
            .foreground(role.foreground)
        }
        .disabled(isTranslucent)
        .background(role.background)
        .clipShape(type.shape)
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
        let icon = Dodam.icon(.plus)
        let action: () async -> Void = {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
        }
        return VStack(alignment: .leading) {
            DodamButton.fullWidth(
                title: title,
                leadingIcon: icon,
                trailingIcon: icon,
                action: action
            )
            .role(role)
            DodamButton.fullWidth(
                title: title,
                leadingIcon: icon,
                trailingIcon: icon,
                action: action
            )
            .disabled()
            .role(role)
            DodamButton.medium(
                title: title,
                leadingIcon: icon,
                trailingIcon: icon,
                action: action
            )
            .role(role)
            DodamButton.medium(
                title: title,
                leadingIcon: icon,
                trailingIcon: icon,
                action: action
            )
            .disabled()
            .role(role)
            DodamButton.small(
                title: title,
                leadingIcon: icon,
                trailingIcon: icon,
                action: action
            )
            .role(role)
            DodamButton.small(
                title: title,
                leadingIcon: icon,
                trailingIcon: icon,
                action: action
            )
            .disabled()
            .role(role)
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
        .registerSUIT()
    }
}

#Preview {
    ButtonPreview()
}

#Preview {
    ButtonPreview()
        .preferredColorScheme(.dark)
}
