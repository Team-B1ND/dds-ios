import SwiftUI

public struct DodamPallete {
    private init() {}
    public static let shared = DodamPallete()
    
    // MARK: - Common
    public let common0 = Color(0x000000)
    public let common100 = Color(0xFFFFFF)
    
    // MARK: - Neutral
    public let neutral5 = Color(0x0F0F10)
    public let neutral10 = Color(0x111212)
    public let neutral15 = Color(0x232424)
    public let neutral20 = Color(0x2A2B2C)
    public let neutral25 = Color(0x383A3B)
    public let neutral30 = Color(0x48494A)
    public let neutral40 = Color(0x5D5F60)
    public let neutral50 = Color(0x747678)
    public let neutral60 = Color(0x8B8D8F)
    public let neutral70 = Color(0x9B9D9F)
    public let neutral80 = Color(0xB0B2B4)
    public let neutral90 = Color(0xC4C5C6)
    public let neutral95 = Color(0xDCDDDE)
    public let neutral97 = Color(0xE6E6E7)
    public let neutral99 = Color(0xF5F5F5)
    
    // MARK: - Blue
    public let blue10 = Color(0x001C33)
    public let blue20 = Color(0x003866)
    public let blue30 = Color(0x005499)
    public let blue40 = Color(0x006FCC)
    public let blue45 = Color(0x0083F0)
    public let blue50 = Color(0x008BFF)
    public let blue60 = Color(0x33A2FF)
    public let blue70 = Color(0x66BAFF)
    public let blue80 = Color(0x99D1FF)
    public let blue90 = Color(0xCCE8FF)
    public let blue95 = Color(0xE5F3FF)
    public let blue99 = Color(0xFAFDFF)
    
    // MARK: - Red
    public let red10 = Color(0x3B0101)
    public let red20 = Color(0x750404)
    public let red30 = Color(0xB20C0C)
    public let red40 = Color(0xE52222)
    public let red50 = Color(0xFF4242)
    public let red60 = Color(0xFF6363)
    public let red70 = Color(0xFF8C8C)
    public let red80 = Color(0xFFB5B5)
    public let red90 = Color(0xFED5D5)
    public let red95 = Color(0xFEECEC)
    public let red99 = Color(0xFFFAFA)
    
    // MARK: - Green
    public let green10 = Color(0x00240C)
    public let green20 = Color(0x004517)
    public let green30 = Color(0x006E25)
    public let green40 = Color(0x009632)
    public let green50 = Color(0x00BF40)
    public let green60 = Color(0x1ED45A)
    public let green70 = Color(0x49E57D)
    public let green80 = Color(0x7DF5A5)
    public let green90 = Color(0xACFCC7)
    public let green95 = Color(0xD9FFE6)
    public let green99 = Color(0xF2FFF6)
    
    // MARK: - Yellow
    public let yellow10 = Color(0x362A00)
    public let yellow20 = Color(0x665000)
    public let yellow30 = Color(0x9C7A00)
    public let yellow40 = Color(0xD4A800)
    public let yellow50 = Color(0xFFC800)
    public let yellow60 = Color(0xFFD338)
    public let yellow70 = Color(0xFFE06E)
    public let yellow80 = Color(0xFFE99C)
    public let yellow90 = Color(0xFEF2C5)
    public let yellow95 = Color(0xFEF9E6)
    public let yellow99 = Color(0xFFFDF7)
}

#Preview {
    
    func makePreview(_ colors: [Color]) -> some View {
        VStack(spacing: 0) {
            ForEach(colors, id: \.self) {
                $0.frame(maxWidth: .infinity, maxHeight: 10)
            }
        }
    }
    
    return VStack(spacing: 0) {
        let P = DodamPallete.shared
        let commons = [P.common0, P.common100]
        makePreview(commons)
        
        let neutrals = [P.neutral5,
                        P.neutral10,
                        P.neutral15,
                        P.neutral20,
                        P.neutral25,
                        P.neutral30,
                        P.neutral40,
                        P.neutral50,
                        P.neutral60,
                        P.neutral70,
                        P.neutral80,
                        P.neutral90,
                        P.neutral95,
                        P.neutral97,
                        P.neutral99]
        makePreview(neutrals)
        
        
        let blues = [P.blue10,
                     P.blue20,
                     P.blue30,
                     P.blue40,
                     P.blue45,
                     P.blue50,
                     P.blue60,
                     P.blue70,
                     P.blue80,
                     P.blue90,
                     P.blue95,
                     P.blue99]
        makePreview(blues)
        
        // MARK: - Red
        let reds = [P.red10,
                    P.red20,
                    P.red30,
                    P.red40,
                    P.red50,
                    P.red60,
                    P.red70,
                    P.red80,
                    P.red90,
                    P.red95,
                    P.red99]
        makePreview(reds)
        
        // MARK: - Green
        let greens = [P.green10,
                      P.green20,
                      P.green30,
                      P.green40,
                      P.green50,
                      P.green60,
                      P.green70,
                      P.green80,
                      P.green90,
                      P.green95,
                      P.green99]
        makePreview(greens)
        
        // MARK: - Yellow
        let yellows = [P.yellow10,
                       P.yellow20,
                       P.yellow30,
                       P.yellow40,
                       P.yellow50,
                       P.yellow60,
                       P.yellow70,
                       P.yellow80,
                       P.yellow90,
                       P.yellow95,
                       P.yellow99]
        makePreview(yellows)
    }
}
