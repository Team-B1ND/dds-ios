import SwiftUI

@available(macOS 12, iOS 15, *)
public struct DodamLabel: DodamTypography {
    
    public let size: CGFloat = 14
    public let weight: SUIT.Weight
    public let lineHeight: Double = 1.4
    
    public static let bold: Self  = .init(weight: .semibold)
    public static let medium: Self = .init(weight: .medium)
    public static let regular: Self  = .init(weight: .regular)
}
