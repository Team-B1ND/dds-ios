import SwiftUI

@available(macOS 12, iOS 15, *)
public struct DodamTitle: DodamTypography {
    
    public let size: CGFloat
    public let weight: SUIT.Weight
    
    public static let large: Self  = .init(size: 22, weight: .bold)
    public static let medium: Self = .init(size: 18, weight: .bold)
    public static let small: Self  = .init(size: 16, weight: .bold)
}
