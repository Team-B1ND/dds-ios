//
//  Tag.swift
//
//
//  Created by hhhello0507 on 7/21/24.
//

import SwiftUI

public struct Tag: View {
    
    public enum TagType {
        case primary
        case secondary
        case negative
        
        var color: DodamColorable {
            switch self {
            case .primary: DodamColor.Primary.normal
            case .secondary: DodamColor.Line.normal
            case .negative: DodamColor.Status.negative
            }
        }
    }
    
    private let title: String
    private let type: TagType
    
    public init(
        _ title: String,
        type: TagType
    ) {
        self.title = title
        self.type = type
    }
    
    public var body: some View {
        Text(title)
            .body(.bold)
            .foreground(DodamColor.Static.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 4)
            .background(type.color)
            .clipShape(.large)
    }
}

private struct TagPreview: View {
    
    init() {
        SUIT.register()
    }
    
    var body: some View {
        VStack {
            Tag("승인됨", type: .primary)
            Tag("대기 중", type: .secondary)
            Tag("거절됨", type: .negative)
        }
        .background(DodamColor.Background.normal)
    }
}

#Preview {
    TagPreview()
}

#Preview {
    TagPreview()
        .preferredColorScheme(.dark)
}
