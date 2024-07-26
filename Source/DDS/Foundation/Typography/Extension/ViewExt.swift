import SwiftUI

@available(macOS 12, iOS 15, *)
public extension View {
    
    func registerPretendard() -> some View {
        Pretendard.register()
        return self
    }
}

private struct DodamFontViewModifier: ViewModifier {
    let font: DodamTypography
    let uiFont: UIFont
    
    init(font: DodamTypography) {
        self.font = font
        self.uiFont = .uiFontGuide(font)
    }

    func body(content: Content) -> some View {
        let lineSpacing = font.calcedLineHeight - uiFont.lineHeight
        return content
            .font(Font(font))
            .lineSpacing(lineSpacing)
            .padding(.vertical, lineSpacing / 2)
    }
}

@available(macOS 12, iOS 15, *)
public extension View {
    
    private func dodamFont(_ type: DodamTypography) -> some View {
        self.modifier(DodamFontViewModifier(font: type))
    }
    
    func title1(_ type: DodamTitle1) -> some View {
        dodamFont(type)
    }
    
    func title2(_ type: DodamTitle2) -> some View {
        dodamFont(type)
    }
    
    func title3(_ type: DodamTitle3) -> some View {
        dodamFont(type)
    }
    
    func heading1(_ type: DodamHeading1) -> some View {
        dodamFont(type)
    }
    
    func heading2(_ type: DodamHeading2) -> some View {
        dodamFont(type)
    }
    
    func headline(_ type: DodamHeadline) -> some View {
        dodamFont(type)
    }
    
    func body1(_ type: DodamBody1) -> some View {
        dodamFont(type)
    }
    
    func body2(_ type: DodamBody2) -> some View {
        dodamFont(type)
    }
    
    func label(_ type: DodamLabel) -> some View {
        dodamFont(type)
    }
    
    func caption1(_ type: DodamCaption1) -> some View {
        dodamFont(type)
    }
    
    func caption2(_ type: DodamCaption2) -> some View {
        dodamFont(type)
    }
}

#Preview {
    let str = "스마트 스쿨 플랫폼 도담도담도담\n바인드는 우주 최강 동아리입니다"
    Pretendard.register()
    return (
        ScrollView {
            VStack(spacing: 44) {
                Text("Title1")
                VStack(spacing: 20) {
                    Text(str)
                        .title1(.bold)
                    Text(str)
                        .title1(.medium)
                    Text(str)
                        .title1(.regular)
                }
                Text("Title2")
                VStack(spacing: 20) {
                    Text(str)
                        .title2(.bold)
                    Text(str)
                        .title2(.medium)
                    Text(str)
                        .title2(.regular)
                }
                Text("Title3")
                VStack(spacing: 20) {
                    Text(str)
                        .title3(.bold)
                    Text(str)
                        .title3(.medium)
                    Text(str)
                        .title3(.regular)
                }
                Text("heading1")
                VStack(spacing: 20) {
                    Text(str)
                        .heading1(.bold)
                    Text(str)
                        .heading1(.medium)
                    Text(str)
                        .heading1(.regular)
                }
                Text("heading2")
                VStack(spacing: 20) {
                    Text(str)
                        .heading2(.bold)
                    Text(str)
                        .heading2(.medium)
                    Text(str)
                        .heading2(.regular)
                }
                Text("headline")
                VStack(spacing: 20) {
                    Text(str)
                        .headline(.bold)
                    Text(str)
                        .headline(.medium)
                    Text(str)
                        .headline(.regular)
                }
                Text("body1")
                VStack(spacing: 20) {
                    Text(str)
                        .body1(.bold)
                    Text(str)
                        .body1(.medium)
                    Text(str)
                        .body1(.regular)
                }
                Text("body2")
                VStack(spacing: 20) {
                    Text(str)
                        .body2(.bold)
                    Text(str)
                        .body2(.medium)
                    Text(str)
                        .body2(.regular)
                }
                Text("label")
                VStack(spacing: 20) {
                    Text(str)
                        .label(.bold)
                    Text(str)
                        .label(.medium)
                    Text(str)
                        .label(.regular)
                }
                Text("caption1")
                VStack(spacing: 20) {
                    Text(str)
                        .caption1(.bold)
                    Text(str)
                        .caption1(.medium)
                    Text(str)
                        .caption1(.regular)
                }
                Text("caption2")
                VStack(spacing: 20) {
                    Text(str)
                        .caption2(.bold)
                    Text(str)
                        .caption2(.medium)
                    Text(str)
                        .caption2(.regular)
                }
            }
        }
    )
}

#Preview {
    VStack {
        let _ = Pretendard.register()
        let headline = DodamHeadline(weight: .bold)
        let font = Font(headline)
        let uiFont = UIFont.uiFontGuide(headline)
        let lineSpacing = headline.calcedLineHeight - uiFont.lineHeight
        ZStack {
            Text("도담도담 알리모\n바인드")
                .headline(.bold)
                .background(.blue)
            Text("도담도담 알리모\n바인드")
                .font(font)
                .lineSpacing(lineSpacing)
                .background(.red)
        }
    }
}
