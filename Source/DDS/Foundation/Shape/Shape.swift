import Foundation

public enum DodamShape {
    case extraSmall
    case small
    case medium
    case large
    case extraLarge
    
    public var radius: CGFloat {
        switch self {
        case .extraSmall: 8
        case .small: 10
        case .medium: 12
        case .large: 18
        case .extraLarge: 28
        }
    }
}
