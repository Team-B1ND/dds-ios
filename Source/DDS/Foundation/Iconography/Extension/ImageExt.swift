import SwiftUI

@available(macOS 12, iOS 15, *)
public extension Image {
    
    init(icon: DodamIconography) {
        self = Image(icon.rawValue, bundle: .module)
    }
}
