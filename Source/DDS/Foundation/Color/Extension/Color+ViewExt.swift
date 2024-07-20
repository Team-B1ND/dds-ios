import SwiftUI


public enum ColorStyle {
    case foreground
    case background
    case tint
}

@available(macOS 12, iOS 15, *)
public extension View {
    
    func foreground(_ color: DodamColorable) -> some View {
        self.foregroundStyle(color.color.rawValue)
    }
    
    func background(_ color: DodamColorable) -> some View {
        self.background(color.color.rawValue)
    }
    
    func tint(_ color: DodamColorable) -> some View {
        self.tint(color.color.rawValue)
    }
}
