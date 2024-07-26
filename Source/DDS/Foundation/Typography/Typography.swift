import SwiftUI

@available(macOS 12, iOS 15, *)
public protocol DodamTypography {
    
    var size: CGFloat { get }
    var weight: Pretendard.Weight { get }
    var lineHeight: Double { get } // percentage
}

extension DodamTypography {
    
    var calcedLineHeight: Double {
        size * lineHeight
    }
}
