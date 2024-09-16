//
//  CryptoImage.swift
//  MarshallCrypto
//
//  Created by David Geijer on 2024-09-13.
//

import SwiftUI

struct CryptoImage: View {
    
    var cryptoId: Int
    
    var body: some View {
        selectImage(for: cryptoId)
            .resizable()
            .scaledToFit()
            .frame(width: 32, height: 32)
    }
    
    private func selectImage(for id: Int) -> Image {
        switch CryptoCurrency(rawValue: id) {
            case .BTC:
                Image("BTC_image")
            case .USDT:
                Image("Tether_image")
            case .ETH:
                Image("ETH_image")
            case .SOL:
                Image("Solana_image")
            case .BNB:
                Image("BNB_image")
        default:
            Image("BTC_image")
        }
    }
}

#Preview {
    CryptoImage(cryptoId: 5426)
}
