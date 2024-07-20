import SwiftUI

@available(macOS 12, iOS 15, *)
public extension Color {
    
    static func dodam(_ dodamColor: DodamColor) -> Color {
        dodamColor.rawValue
    }
    
    init(_ hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
