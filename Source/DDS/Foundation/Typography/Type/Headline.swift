import SwiftUI

@available(macOS 12, iOS 15, *)
public struct DodamHeadline: DodamTypography {
    
    public let size: CGFloat
    public let weight: SUIT.Weight
    
    public static let large: Self  = .init(size: 32, weight: .extrabold)
    public static let medium: Self = .init(size: 28, weight: .bold)
    public static let small: Self  = .init(size: 24, weight: .bold)
}
