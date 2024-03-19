import SwiftUI

@available(macOS 12, iOS 15, *)
public extension Color {
    
    static func dodam(_ dodamColor: DodamColor) -> Color {
        dodamColor.rawValue
    }
}
