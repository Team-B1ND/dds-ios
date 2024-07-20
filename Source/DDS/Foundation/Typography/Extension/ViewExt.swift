import SwiftUI

@available(macOS 12, iOS 15, *)
public extension View {
    
    func registerSUIT() -> some View {
        SUIT.register()
        return self
    }
}

@available(macOS 12, iOS 15, *)
public extension View {
    
    func title1(_ type: DodamTitle1) -> some View {
        self.font(.title1(type))
            .lineSpacing(type.lineHeight - 1)
    }
    
    func title2(_ type: DodamTitle2) -> some View {
        self.font(.title2(type))
            .lineSpacing(type.lineHeight - 1)
    }
    
    func title3(_ type: DodamTitle3) -> some View {
        self.font(.title3(type))
            .lineSpacing(type.lineHeight - 1)
    }
    
    func heading1(_ type: DodamHeading1) -> some View {
        self.font(.heading1(type))
            .lineSpacing(type.lineHeight - 1)
    }
    
    func heading2(_ type: DodamHeading2) -> some View {
        self.font(.heading2(type))
            .lineSpacing(type.lineHeight - 1)
    }
    
    func headline(_ type: DodamHeadline) -> some View {
        self.font(.headline(type))
            .lineSpacing(type.lineHeight - 1)
    }
    
    func body(_ type: DodamBody) -> some View {
        self.font(.body(type))
            .lineSpacing(type.lineHeight - 1)
    }
    
    func label(_ type: DodamLabel) -> some View {
        self.font(.label(type))
            .lineSpacing(type.lineHeight - 1)
    }
    
    func caption1(_ type: DodamCaption1) -> some View {
        self.font(.caption1(type))
            .lineSpacing(type.lineHeight - 1)
    }
    
    func caption2(_ type: DodamCaption2) -> some View {
        self.font(.caption2(type))
            .lineSpacing(type.lineHeight - 1)
    }
}
