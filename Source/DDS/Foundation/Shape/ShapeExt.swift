import SwiftUI

@available(macOS 12, iOS 15, *)
public extension Shape {
    
    func dodamFill(_ color: DodamColorable) -> some View {
        self.fill(color.color.rawValue)
    }
    
    func dodamStroke(_ color: DodamColorable, lineWidth: CGFloat = 1) -> some View {
        self.stroke(color.color.rawValue, lineWidth: lineWidth)
    }
}

@available(macOS 12, iOS 15, *)
public extension View {
    func clipShape(_ shape: DodamShape) -> some View {
        self.clipShape(RoundedRectangle(cornerRadius: shape.radius))
    }
}
