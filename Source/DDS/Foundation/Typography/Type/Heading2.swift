import SwiftUI

@available(macOS 12, iOS 15, *)
public struct DodamHeading2: DodamTypography {
    
    public let size: CGFloat = 20
    public let weight: SUIT.Weight
    public let lineHeight: Double = 1.4
    
    public static let large: Self  = .init(weight: .extrabold)
    public static let medium: Self = .init(weight: .medium)
    public static let small: Self  = .init(weight: .regular)
}
