import SwiftUI

@available(macOS 12, iOS 15, *)
public struct DodamBody: DodamTypography {
    
    public let size: CGFloat
    public let weight: Font.Weight
    
    public static let large: Self  = .init(size: 18, weight: .semibold)
    public static let medium: Self = .init(size: 16, weight: .semibold)
    public static let small: Self  = .init(size: 14, weight: .medium)
}
