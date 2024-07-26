import SwiftUI

@available(macOS 12, iOS 15, *)
public protocol DodamTypography {
    
    var size: CGFloat { get }
    var weight: SUIT.Weight { get }
    var lineHeight: Double { get } // percent
}

extension DodamTypography {
    
    var calcedLineHeight: Double {
        size * lineHeight
    }
}
