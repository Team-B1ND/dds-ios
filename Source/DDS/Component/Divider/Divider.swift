import SwiftUI

public struct DodamDivider: View {
    
    public enum DividerType {
        case line
        case thick
        
        var size: CGFloat {
            switch self {
            case .line: 1
            case .thick: 8
            }
        }
    }
    
    private let type: DividerType
    
    public init(type: DividerType = .line) {
        self.type = type
    }
    
    public var body: some View {
        Rectangle()
            .dodamFill(DodamColor.Line.alternative)
            .frame(maxWidth: .infinity)
            .frame(height: type.size)
    }
}

private struct DodamDividerPreview: View {
    var body: some View {
        VStack {
            DodamDivider(type: .line)
            DodamDivider(type: .thick)
        }
    }
}

#Preview {
    DodamDividerPreview()
}

#Preview {
    DodamDividerPreview()
        .preferredColorScheme(.dark)
}
