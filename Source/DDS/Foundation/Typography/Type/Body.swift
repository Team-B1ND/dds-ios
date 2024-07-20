import SwiftUI

@available(macOS 12, iOS 15, *)
public struct DodamBody: DodamTypography {
    
    public let size: CGFloat = 16
    public let weight: SUIT.Weight
    public let lineHeight: Double = 1.5
    
    public static let large: Self  = .init(weight: .bold)
    public static let medium: Self = .init(weight: .medium)
    public static let small: Self  = .init(weight: .regular)
}
