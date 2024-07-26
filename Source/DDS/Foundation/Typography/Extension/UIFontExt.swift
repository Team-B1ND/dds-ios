import UIKit

@available(macOS 12, iOS 15, *)
public extension UIFont {
    static func uiFontGuide(_ font: DodamTypography) -> UIFont {
        return UIFont(name: font.weight.rawValue, size: font.size)!
    }
}
