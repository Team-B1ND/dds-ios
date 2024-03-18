import SwiftUI

@available(macOS 12, iOS 15, *)
public struct DodamIcon: View {
    
    private let icon: DodamIconography
    private let size: CGFloat?
    
    public init(
        _ icon: DodamIconography,
        size: CGFloat? = nil
    ) {
        self.icon = icon
        self.size = size
    }
    
    public var body: some View {
        Image(icon: icon)
            .frame(width: size, height: size)
    }
}

#Preview {
    DodamIcon(.home, size: 50)
}
