import SwiftUI

@available(macOS 12, iOS 15, *)
public struct SUIT {
    
    public enum Weight: String, CaseIterable {
        
        case regular = "SUIT-Regular"
        case medium = "SUIT-Medium"
        case semibold = "SUIT-SemiBold"
        case bold = "SUIT-Bold"
        case extrabold = "SUIT-ExtraBold"
    }
    
    public static func register() {
        SUIT.Weight.allCases.forEach {
            guard let fontURL = Bundle.module.url(
                forResource: $0.rawValue,
                withExtension: "otf"
            ),
                  let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
                  let font = CGFont(fontDataProvider) else { return }
            var error: Unmanaged<CFError>?
            CTFontManagerRegisterGraphicsFont(font, &error)
        }
    }
}
