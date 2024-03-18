import SwiftUI

@available(macOS 12, iOS 15, *)
public struct DodamLabel: DodamTypography {
    
    public let size: CGFloat
    public let weight: Font.Weight
    
    public static let large: Self  = .init(size: 14, weight: .medium)
    public static let medium: Self = .init(size: 12, weight: .medium)
    public static let small: Self  = .init(size: 11, weight: .regular)
}
