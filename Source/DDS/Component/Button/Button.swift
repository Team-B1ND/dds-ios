import SwiftUI

extension DodamButton.ButtonType {
    var shape: DodamShape {
        switch self {
        case .cta: .small
        case .large: .small
        case .medium: .small
        case .small: .extraSmall
        }
    }
    
    var height: CGFloat {
        switch self {
        case .cta: 48
        case .large: 44
        case .medium: 40
        case .small: 36
        }
    }
    
    var horizontalPadding: CGFloat {
        switch self {
        case .cta: 12
        case .large: 12
        case .medium: 8
        case .small: 8
        }
    }
    
    var iconSize: CGFloat {
        switch self {
        case .cta: 20
        case .large: 20
        case .medium: 18
        case .small: 14
        }
    }
    
    var titleHorizontalPadding: CGFloat {
        switch self {
        case .cta: 8
        case .large: 8
        case .medium: 6
        case .small: 4
        }
    }
    
    var font: Font {
        switch self {
        case .cta: .body1(.medium)
        case .large: .body1(.medium)
        case .medium: .body1(.medium)
        case .small: .label(.medium)
        }
    }
}

@available(macOS 12, iOS 15, *)
public struct DodamButton: View {
    
    public enum ButtonType {
        case cta
        case large
        case medium
        case small
    }
    
    public typealias AsyncAction = () async -> Void
    
    private let type: ButtonType
    private let title: String
    private let leadingIcon: Image?
    private let trailingIcon: Image?
    private let action: AsyncAction
    private let isDisabled: Bool
    private let background: DodamColorable
    private let foreground: DodamColorable
    
    private init(
        type: ButtonType,
        title: String,
        leadingIcon: Image?,
        trailingIcon: Image?,
        action: @escaping AsyncAction,
        isDisabled: Bool = false,
        background: DodamColorable = DodamColor.Primary.normal,
        foreground: DodamColorable = DodamColor.Static.white
    ) {
        self.type = type
        self.title = title
        self.leadingIcon = leadingIcon
        self.trailingIcon = trailingIcon
        self.action = action
        self.isDisabled = isDisabled
        self.background = background
        self.foreground = foreground
    }
    
    public static func fullWidth(
        title: String,
        leadingIcon: Image? = nil,
        trailingIcon: Image? = nil,
        action: @escaping AsyncAction
    ) -> Self {
        .init(
            type: .cta,
            title: title,
            leadingIcon: leadingIcon,
            trailingIcon: trailingIcon,
            action: action
        )
    }
    
    public static func large(
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
            background: self.background,
            foreground: self.foreground
        )
    }
    
    public func background(_ color: DodamColorable) -> Self {
        .init(
            type: self.type,
            title: self.title,
            leadingIcon: self.leadingIcon,
            trailingIcon: self.trailingIcon,
            action: self.action,
            isDisabled: self.isDisabled,
            background: color,
            foreground: self.foreground
        )
    }
    
    public func foreground(_ color: DodamColorable) -> Self {
        .init(
            type: self.type,
            title: self.title,
            leadingIcon: self.leadingIcon,
            trailingIcon: self.trailingIcon,
            action: self.action,
            isDisabled: self.isDisabled,
            background: self.background,
            foreground: color
        )
    }
    
    @State private var isPerformingTask: Bool = false
    
    private var maxWidth: CGFloat? {
        guard type != .cta else { return .infinity }
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
            HStack(spacing: 0) {
                if let leadingIcon {
                    leadingIcon
                        .resizable()
                        .scaledToFit()
                        .frame(width: type.iconSize,height: type.iconSize)
                }
                Text(title)
                    .font(type.font)
                    .padding(.horizontal, type.titleHorizontalPadding)
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
            .foreground(foreground)
        }
        .disabled(isTranslucent)
        .background(background)
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
    var body: some View {
        VStack(alignment: .leading) {
            let title = "로그인"
            let icon = Dodam.icon(.home)
            let action: () async -> Void = {
                try? await Task.sleep(nanoseconds: 1_000_000_000)
            }
            DodamButton.fullWidth(
                title: title,
                leadingIcon: icon,
                trailingIcon: icon,
                action: action
            )
            DodamButton.large(
                title: title,
                leadingIcon: icon,
                trailingIcon: icon,
                action: action
            )
            DodamButton.medium(
                title: title,
                leadingIcon: icon,
                action: action
            )
            DodamButton.small(
                title: title,
                leadingIcon: icon,
                action: action
            )
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
