import SwiftUI

public struct DodamColor {
    
    public let color: Color
    
    private init(
        hex: String,
        dark: String? = nil
    ) {
        let lightColor = UIColor(hex: hex)
        if dark == nil {
            color = Color(lightColor)
        } else {
            let darkColor = UIColor(hex: dark!)
            color = Color(UIColor {
                if $0.userInterfaceStyle == .dark {
                    darkColor
                } else {
                    lightColor
                }
            })
        }
    }
    
    public static let primary: Self          = .init(hex: "#0083F0")
    public static let onPrimary: Self        = .init(hex: "#FFFFFF")
    public static let secondary: Self        = .init(hex: "#EFEFEF", dark: "#3F3F3F")
    public static let tertiary: Self         = .init(hex: "#3F3F3F", dark: "#555555")
    public static let surface: Self          = .init(hex: "#F2F5F8", dark: "#111111")
    public static let onSurface: Self        = .init(hex: "#111111", dark: "#FFFFFF")
    public static let surfaceContainer: Self = .init(hex: "#FFFFFF", dark: "#1F1F1F")
    public static let onSurfaceVariant: Self = .init(hex: "#B7B7B7", dark: "#777777")
    public static let outline: Self          = .init(hex: "#DFDFDF", dark: "#555555")
    public static let outlineVariant: Self   = .init(hex: "#EFEFEF", dark: "#383838")
}
