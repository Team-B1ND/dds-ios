import SwiftUI

@available(macOS 12, iOS 15, *)
public struct Dodam {
    
    public static func icon(_ icon: DodamIconography) -> Image {
        .init(icon: icon)
    }
    
    public static func icon(
        _ icon: DodamIconography,
        size: CGFloat
    ) -> some View {
        Image(icon: icon)
            .resizable()
            .frame(width: size, height: size)
    }
    
    public static func color(_ color: DodamColor) -> Color {
        color.rawValue
    }
}
