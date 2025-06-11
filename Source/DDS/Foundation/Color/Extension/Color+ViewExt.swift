import SwiftUI

#if os(iOS)
public enum ColorStyle {
    case foreground
    case background
    case tint
}

@available(macOS 12, iOS 15, *)
public extension View {
    
    func foreground(_ color: DodamColorable, opacity: Double = 1) -> some View {
        self.foregroundStyle(color.color.rawValue.opacity(opacity))
    }
    
    func background(_ color: DodamColorable, opacity: Double = 1) -> some View {
        self.background(color.color.rawValue.opacity(opacity))
    }
    
    func tint(_ color: DodamColorable, opacity: Double = 1) -> some View {
        self.tint(color.color.rawValue.opacity(opacity))
    }
}
#endif
