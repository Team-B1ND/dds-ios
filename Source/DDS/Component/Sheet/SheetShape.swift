import SwiftUI

@available(macOS 12, iOS 15, *)
struct DodamSheetShape: Shape {
    
    let radius: CGFloat = 20
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let w = rect.size.width
        let h = rect.size.height
        let radius = min(min(self.radius, h/2), w/2)
        
        path.move(to: .init(x: w / 2.0, y: 0))
        path.addLine(to: .init(x: w - radius, y: 0))
        path.addArc(center: .init(x: w - radius, y: radius),
                    radius: radius,
                    startAngle: .init(degrees: -90),
                    endAngle: .init(degrees: 0), clockwise: false)
        
        path.addLine(to: .init(x: w, y: h - 0))
        path.addLine(to: .init(x: 0, y: h))
        
        path.addLine(to: .init(x: 0, y: radius))
        path.addArc(center: .init(x: radius, y: radius),
                    radius: radius,
                    startAngle: .init(degrees: 180),
                    endAngle: .init(degrees: 270), clockwise: false)
        
        path.closeSubpath()
        return path
    }
}
