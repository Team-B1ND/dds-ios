import SwiftUI

struct SnapScrollView<T, C: View>: View {
    @State private var isDragging = false
    @State private var transition = CGSize.zero
    @State private var itemSize = CGSize.zero
    
    let data: [T]
    @Binding private var selection: Int
    let spacing: CGFloat
    let showItemCount: Int
    let itemWidth: CGFloat?
    let content: (T) -> C
    
    init(
        _ data: [T],
        selection: Binding<Int>,
        spacing: CGFloat = 0,
        showItemCount: Int,
        itemWidth: CGFloat? = nil,
        @ViewBuilder content: @escaping (T) -> C
    ) {
        self.data = data
        self._selection = selection
        self.spacing = spacing
        self.showItemCount = showItemCount
        self.itemWidth = itemWidth
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                ForEach(Array(data.enumerated()), id: \.offset) { idx, color in
                    content(color)
                        .offset(
                            y: CGFloat(idx - selection + showItemCount / 2) * itemSize.height
                            + spacing * CGFloat(idx - selection + showItemCount / 2)
                        )
                        .background {
                            GeometryReader { geo in
                                Color.clear
                                    .onAppear {
                                        if geo.size.width > itemSize.width {
                                            itemSize = geo.size
                                        }
                                    }
                            }
                        }
                        .frame(height: itemSize.height)
                        .offset(y: isDragging ? transition.height : 0)
                        .animation(.spring, value: selection)
                        .animation(.spring, value: isDragging)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        self.transition = value.translation
                        isDragging = true
                    }
                    .onEnded { value in
                        var offset = value.translation.height / itemSize.height
                        offset += offset > 0 ? 0.5 : -0.5
                        let calcedOffset = Int(offset)
                        let resultOffset = selection - calcedOffset
                        isDragging = false
                        if value.translation.height < 0 { // to end
                            selection = min(resultOffset, data.count - 1)
                        } else if value.translation.height > offset { // to start
                            selection = max(resultOffset, 0)
                        }
                    }
            )
        }
        .frame(height: itemSize.height * CGFloat(showItemCount) + spacing * CGFloat(showItemCount - 1))
        .frame(width: {
            if let itemWidth {
                itemWidth
            } else if itemSize.width == .zero {
                nil
            } else {
                itemSize.width
            }
        }())
        .clipped()
    }
}
