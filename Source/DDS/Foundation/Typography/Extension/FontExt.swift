import SwiftUI

@available(macOS 12, iOS 15, *)
public extension Font {
    
    init(_ dodamTypography: DodamTypography) {
        self = .suit(
            size: dodamTypography.size,
            weight: dodamTypography.weight
        )
    }
    
    static func suit(size: CGFloat, weight: SUIT.Weight) -> Font {
        custom(weight.rawValue, fixedSize: size)
    }
    
    static func title1(_ type: DodamTitle1) -> Font {
        .init(type)
    }
    
    static func title2(_ type: DodamTitle2) -> Font {
        .init(type)
    }
    
    static func title3(_ type: DodamTitle3) -> Font {
        .init(type)
    }
    
    static func heading1(_ type: DodamHeading1) -> Font {
        .init(type)
    }
    
    static func heading2(_ type: DodamHeading2) -> Font {
        .init(type)
    }
    
    static func headline(_ type: DodamHeadline) -> Font {
        .init(type)
    }
    
    static func body(_ type: DodamBody) -> Font {
        .init(type)
    }
    
    static func label(_ type: DodamLabel) -> Font {
        .init(type)
    }
    
    static func caption1(_ type: DodamCaption1) -> Font {
        .init(type)
    }
    
    static func caption2(_ type: DodamCaption2) -> Font {
        .init(type)
    }
}
