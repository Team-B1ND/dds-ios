import SwiftUI

public struct DodamEmptyView: View {
    
    public enum EmptyType: String {
        case outGoing = "외출"
        case outSleeping = "외박"
        case nightStudy = "심야 자습"
    }
    
    private let emptyType: EmptyType
    private let action: () -> Void
    
    public init(
        _ emptyType: EmptyType,
        action: @escaping () -> Void
    ) {
        self.emptyType = emptyType
        self.action = action
    }
    
    private var icon: Image {
        switch emptyType {
        case .outGoing: return .init(icon: .convenienceStore)
        case .outSleeping: return .init(icon: .tent)
        case .nightStudy: return .init(icon: .fullMoonFace)
        }
    }
    
    public var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 12) {
                icon
                .frame(width: 36, height: 36)
                Text("아직 신청한 \(emptyType.rawValue)이 없어요.")
                    .font(.label(.large))
                    .dodamColor(.onSurfaceVariant)
            }
            .padding(.top, 16)
            Button {
                action()
            } label: {
                Text("\(emptyType.rawValue) 신청하기")
                    .font(.body(.large))
                    .dodamColor(.onSecondaryContainer)
                    .padding(.vertical, 14)
                    .frame(maxWidth: .infinity)
            }
            .background(Dodam.color(.secondaryContainer))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding([.horizontal, .bottom], 16)
        }
        .background(Dodam.color(.surfaceContainer))
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

#Preview {
    struct DodamContainerPreview: View {
        
        var body: some View {
            VStack(spacing: 20) {
                DodamEmptyView(.outGoing) {}
                DodamEmptyView(.outSleeping) {}
                DodamEmptyView(.nightStudy) {}
            }
            .padding(16)
            .background(Dodam.color(.surface))
            .registerSUIT()
        }
    }
    return DodamContainerPreview()
}
