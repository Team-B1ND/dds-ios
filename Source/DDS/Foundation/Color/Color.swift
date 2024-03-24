import SwiftUI

@available(macOS 12, iOS 15, *)
public struct DodamColor: RawRepresentable {
    
    public let rawValue: Color
    
    public init?(rawValue: Color) {
        self.rawValue = rawValue
    }
    
    private init(
        hex: String,
        dark: String? = nil
    ) {
        let lightColor = UIColor(hex: hex)
        if dark == nil {
            rawValue = Color(lightColor)
        } else {
            let darkColor = UIColor(hex: dark!)
            rawValue = Color(UIColor {
                if $0.userInterfaceStyle == .dark {
                    darkColor
                } else {
                    lightColor
                }
            })
        }
    }
    
    public static let primary: Self                 = .init(hex: "#0083F0")
    public static let onPrimary: Self               = .init(hex: "#FFFFFF")
    public static let error: Self                   = .init(hex: "#EF2B2A")
    public static let onError: Self                 = .init(hex: "#FFFFFF")
    public static let secondary: Self               = .init(hex: "#EFEFEF", dark: "#3F3F3F")
    public static let tertiary: Self                = .init(hex: "#616161", dark: "#555555")
    public static let secondaryContainer: Self      = .init(hex: "#EFEFEF", dark: "#3F3F3F")
    public static let onSecondaryContainer: Self    = .init(hex: "#3F3F3F", dark: "#C8C8C8")
    public static let surface: Self                 = .init(hex: "#F2F5F8", dark: "#111111")
    public static let onSurface: Self               = .init(hex: "#111111", dark: "#FFFFFF")
    public static let background: Self              = .init(hex: "#FFFFFF", dark: "#1A1A1A")
    public static let onBackground: Self            = .init(hex: "#111111", dark: "#FFFFFF")
    public static let surfaceContainer: Self        = .init(hex: "#FFFFFF", dark: "#1F1F1F")
    public static let onSurfaceVariant: Self        = .init(hex: "#B7B7B7", dark: "#777777")
    public static let outline: Self                 = .init(hex: "#DFDFDF", dark: "#555555")
    public static let outlineVariant: Self          = .init(hex: "#EFEFEF", dark: "#383838")
    public static let surfaceContainerLow: Self     = .init(hex: "#FFFFFF", dark: "#616161")
    public static let surfaceContainerHigh: Self    = .init(hex: "#FFFFFF", dark: "#1F1F1F")
    public static let surfaceContainerHighest: Self = .init(hex: "#F5F5F5", dark: "#383838")
}
