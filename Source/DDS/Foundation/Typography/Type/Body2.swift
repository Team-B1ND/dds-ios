import SwiftUI

@available(macOS 12, iOS 15, *)
public struct DodamBody2: DodamTypography {
    
    public let size: CGFloat = 15
    public let weight: SUIT.Weight
    public let lineHeight: Double = 1.5
    
    public static let bold: Self  = .init(weight: .semibold)
    public static let medium: Self = .init(weight: .medium)
    public static let regular: Self  = .init(weight: .regular)
}
