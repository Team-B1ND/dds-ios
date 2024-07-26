import SwiftUI

@available(macOS 12, iOS 15, *)
public struct DodamHeadline: DodamTypography {
    
    public let size: CGFloat = 18
    public let weight: Pretendard.Weight
    public let lineHeight: Double = 1.5
    
    public static let bold: Self  = .init(weight: .bold)
    public static let medium: Self = .init(weight: .medium)
    public static let regular: Self  = .init(weight: .regular)
}
