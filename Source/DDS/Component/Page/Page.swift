import SwiftUI

@available(macOS 12, iOS 15, *)
public protocol DodamPageConvertible {
    
    var items: [DodamPage] { get }
}

@available(macOS 12, iOS 15, *)
public struct DodamPage: DodamPageConvertible, View {
    
    @resultBuilder
    public struct Builder {
        
        public static func buildBlock(
            _ components: DodamPageConvertible...
        ) -> [DodamPageConvertible] {
            components
        }
        
        public static func buildFinalResult(
            _ components: [DodamPageConvertible]
        ) -> [DodamPage] {
            components.flatMap(\.items)
        }
    }
    
    public enum Label {
        
        case none
        case text(String)
        case icon(DodamIconography)
    }
    
    public let label: Label
    public let content: AnyView
    
    public var items: [DodamPage] {
        [self]
    }
    
    public var body: Never {
        fatalError()
    }
    
    public init<C: View>(
        _ label: Label = .none,
        @ViewBuilder content: @escaping () -> C
    ) {
        self.label = label
        self.content = AnyView(content())
    }
}
