import SwiftUI

@available(macOS 12, iOS 15, *)
public struct DodamColor: RawRepresentable {
    
    public let rawValue: Color
    
    public init?(rawValue: Color) {
        self.rawValue = rawValue
    }
    
    private init(
        _ light: Color,
        _ dark: Color? = nil
    ) {
        guard let dark else {
            rawValue = light
            return
        }
        rawValue = Color(UIColor {
            if $0.userInterfaceStyle == .dark {
                UIColor(dark)
            } else {
                UIColor(light)
            }
        })
    }
    
    public enum Primary {
        case normal
        case alternative
    }
    public enum Label {
        case normal
        case strong
        case neutral
        case alternative
        case assistive
        case disable
    }
    public enum Line {
        case normal
        case neutral
        case alternative
    }
    public enum Fill {
        case normal
        case neutral
        case alternative
        case assistive
    }
    public enum Background {
        case normal
        case neutral
        case alternative
    }
    public enum Status {
        case negative
        case cautionary
        case positive
    }
    public enum Static {
        case white
        case black
    }
}

extension DodamColor.Primary: DodamColorable, CaseIterable {
    public var color: DodamColor {
        switch self {
        case .normal: .init(P.blue45, P.blue45)
        case .alternative: .init(P.blue45.opacity(0.65), P.blue45.opacity(0.65))
        }
    }
}

extension DodamColor.Label: DodamColorable, CaseIterable {
    public var color: DodamColor {
        switch self {
        case .normal: .init(P.neutral5, P.neutral99)
        case .strong: .init(P.common0, P.common100)
        case .neutral: .init(P.neutral25, P.neutral95)
        case .alternative: .init(P.neutral40, P.neutral90)
        case .assistive: .init(P.neutral50, P.neutral70)
        case .disable: .init(P.neutral97, P.neutral30)
        }
    }
}

extension DodamColor.Line: DodamColorable, CaseIterable {
    public var color: DodamColor {
        switch self {
        case .normal: .init(P.neutral90, P.neutral50)
        case .neutral: .init(P.neutral95, P.neutral30)
        case .alternative: .init(P.neutral97, P.neutral25)
        }
    }
}

extension DodamColor.Fill: DodamColorable, CaseIterable {
    public var color: DodamColor {
        switch self {
        case .normal: .init(P.neutral99, P.neutral25)
        case .neutral: .init(P.neutral97, P.neutral25)
        case .alternative: .init(P.neutral95, P.neutral30)
        case .assistive: .init(P.common100, P.neutral60)
        }
    }
}

extension DodamColor.Background: DodamColorable, CaseIterable {
    public var color: DodamColor {
        switch self {
        case .normal: .init(P.common100, P.neutral15)
        case .neutral: .init(P.neutral99, P.neutral10)
        case .alternative: .init(P.neutral99, P.neutral5)
        }
    }
}

extension DodamColor.Status: DodamColorable, CaseIterable {
    public var color: DodamColor {
        switch self {
        case .negative: .init(P.red50, P.red50)
        case .cautionary: .init(P.yellow50, P.yellow60)
        case .positive: .init(P.green50, P.green60)
        }
    }
}

extension DodamColor.Static: DodamColorable, CaseIterable {
    public var color: DodamColor {
        switch self {
        case .white: .init(P.common100)
        case .black: .init(P.common0)
        }
    }
}

private extension DodamColorable {
    var P: DodamPallete {
        DodamPallete.shared
    }
}

public protocol DodamColorable {
    var color: DodamColor { get }
}


private struct DodamColorPreview: View {
    
    func makePreview(_ colors: [DodamColorable]) -> some View {
        VStack(spacing: 0) {
            ForEach(colors, id: \.color.rawValue) {
                $0.color.rawValue.frame(maxWidth: .infinity, maxHeight: 20)
            }
        }
    }
    
    var body: some View {
        makePreview(DodamColor.Primary.allCases)
        makePreview(DodamColor.Label.allCases)
        makePreview(DodamColor.Line.allCases)
        makePreview(DodamColor.Fill.allCases)
        makePreview(DodamColor.Background.allCases)
        makePreview(DodamColor.Status.allCases)
        makePreview(DodamColor.Static.allCases)
    }
}

#Preview {
    DodamColorPreview()
}

#Preview {
    DodamColorPreview()
        .preferredColorScheme(.dark)
}
