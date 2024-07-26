import SwiftUI

@available(macOS 12, iOS 15, *)
public struct DodamHeading1: DodamTypography {
    
    public let size: CGFloat = 22
    public let weight: Pretendard.Weight
    public let lineHeight: Double = 1.3
    
    public static let bold: Self  = .init(weight: .extrabold)
    public static let medium: Self = .init(weight: .medium)
    public static let regular: Self  = .init(weight: .regular)
}
