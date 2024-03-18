import SwiftUI

@available(macOS 12, iOS 15, *)
public extension Color {
    
    init(_ dodamColor: DodamColor) {
        self = dodamColor.color
    }
}
