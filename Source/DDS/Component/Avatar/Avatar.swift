//
//  File.swift
//  
//
//  Created by hhhello0507 on 9/20/24.
//

import Foundation
import SwiftUI
import CachedAsyncImage

public struct DodamAvatar: View {
    
    public enum Size: CGFloat, CaseIterable {
        case extraSmall = 16
        case small = 24
        case medium = 32
        case large = 36
        case extraLarge = 64
        case xxl = 128
        
        var innerSize: CGFloat {
            rawValue * 5 / 8
        }
    }
    
    private let url: String?
    private let size: Size
    
    public static func extraSmall(url: String?) -> DodamAvatar {
        .init(url: url, size: .extraSmall)
    }

    public static func small(url: String?) -> DodamAvatar {
        .init(url: url, size: .small)
    }
    
    public static func medium(url: String?) -> DodamAvatar {
        .init(url: url, size: .medium)
    }

    public static func large(url: String?) -> DodamAvatar {
        .init(url: url, size: .large)
    }

    public static func extraLarge(url: String?) -> DodamAvatar {
        .init(url: url, size: .extraLarge)
    }

    public static func xxl(url: String?) -> DodamAvatar {
        .init(url: url, size: .xxl)
    }
    
    public var body: some View {
        Group {
            if let url {
                CachedAsyncImage(url: URL(string: url)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .shimmer()
                }
            } else {
                Image(icon: .person)
                    .resizable()
                    .renderingMode(.template)
                    .foreground(DodamColor.Fill.alternative)
                    .frame(width: size.innerSize, height: size.innerSize)
            }
        }
        .frame(width: size.rawValue, height: size.rawValue)
        .background(DodamColor.Fill.normal)
        .clipShape(Circle())
    }
}

#Preview {
    VStack {
        ForEach(DodamAvatar.Size.allCases, id: \.self) {
            DodamAvatar(url: "https://gratisography.com/wp-content/uploads/2024/01/gratisography-cyber-kitty-800x525.jpg", size: $0)
            DodamAvatar(url: nil, size: $0)
        }
    }
    .registerPretendard()
}
