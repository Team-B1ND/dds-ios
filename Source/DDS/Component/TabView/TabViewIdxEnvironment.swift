import SwiftUI

@available(macOS 12, iOS 15, *)
private struct TabViewIdxEnvironmentKey: EnvironmentKey {
    
    static var defaultValue: Int?
}

@available(macOS 12, iOS 15, *)
public extension EnvironmentValues {
    
    var tabViewIdx: Int? {
        get { self [TabViewIdxEnvironmentKey.self] }
        set {
            self [TabViewIdxEnvironmentKey.self] = newValue
        }
    }
}
