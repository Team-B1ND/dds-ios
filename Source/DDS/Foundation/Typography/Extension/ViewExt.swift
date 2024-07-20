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
    }
    
    func title2(_ type: DodamTitle2) -> some View {
        self.font(.title2(type))
    }
    
    func title3(_ type: DodamTitle3) -> some View {
        self.font(.title3(type))
    }
    
    func heading1(_ type: DodamHeading1) -> some View {
        self.font(.heading1(type))
    }
    
    func heading2(_ type: DodamHeading2) -> some View {
        self.font(.heading2(type))
    }
    
    func headline(_ type: DodamHeadline) -> some View {
        self.font(.headline(type))
    }
    
    func body(_ type: DodamBody) -> some View {
        self.font(.body(type))
    }
    
    func label(_ type: DodamLabel) -> some View {
        self.font(.label(type))
    }
    
    func caption1(_ type: DodamCaption1) -> some View {
        self.font(.caption1(type))
    }
    
    func caption2(_ type: DodamCaption2) -> some View {
        self.font(.caption2(type))
    }
}
