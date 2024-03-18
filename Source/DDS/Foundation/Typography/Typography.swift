import SwiftUI

@available(macOS 12, iOS 15, *)
public protocol DodamTypography {
    
    var size: CGFloat { get }
    var weight: Font.Weight { get }
}
