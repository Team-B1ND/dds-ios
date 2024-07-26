import SwiftUI

@available(macOS 12, iOS 15, *)
public struct Pretendard {
    
    public enum Weight: String, CaseIterable {
        
        case regular = "Pretendard-Regular"
        case medium = "Pretendard-Medium"
        case semibold = "Pretendard-SemiBold"
        case bold = "Pretendard-Bold"
        case extrabold = "Pretendard-ExtraBold"
    }
    
    public static func register() {
        Pretendard.Weight.allCases.forEach {
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
