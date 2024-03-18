import SwiftUI

@available(macOS 12, iOS 15, *)
extension ForEach: DodamPageConvertible where Content == DodamPage {
    
    public var items: [DodamPage] {
        data.map(content)
    }
}
