import SwiftUI

@available(macOS 12, iOS 15, *)
public extension Font {
    
    init(_ dodamTypography: DodamTypography) {
        self = .system(
            size: dodamTypography.size,
            weight: dodamTypography.weight
        )
    }
    
    static func headline(_ type: DodamHeadline) -> Font {
        .init(type)
    }
    
    static func title(_ type: DodamTitle) -> Font {
        .init(type)
    }
    
    static func body(_ type: DodamBody) -> Font {
        .init(type)
    }
    
    static func label(_ type: DodamLabel) -> Font {
        .init(type)
    }
}
