//
//  CryptoDetailView.swift
//  MarshallCrypto
//
//  Created by David Geijer on 2024-09-16.
//

import SwiftUI

struct CryptoDetailView: View {
    let item: CryptoModelItem
    
    @Environment(\.currentCurrencyUSD) var isCurrentCurrencyUSD: Bool
    
    var body: some View {
        ZStack {
            
            Color.appBackground
                .ignoresSafeArea()
            LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .bottom)
                .opacity(0.6)
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 10) {
                
                
                CryptoImage(cryptoId: item.id)
                    .padding([.bottom, .top], 40)
                    .shadow(color: .black, radius: 10, x: 0, y: 8)
                
                Text("Symbol: \(item.symbol)")
                    .appFontRegular16()
                    .foregroundStyle(.appText)
                
                Text(formattedPrice(with: item))
                    .appFontSemiBold16()
                    .foregroundStyle(.appText)
                
                Text("Changes the last seven days: \(String(format: "%.3f", item.pricingUSD.usd.percentChange7d)) %")
                    .foregroundColor(item.pricingUSD.usd.percentChange7d >= 0 ? .green : .red)
                    .appFontSemiBold16()
                    .foregroundStyle(.appText)
                
                Text(item.description)
                    .appFontRegular16()
                    .foregroundStyle(.appText)
                    .shadow(color: .black, radius: 10, x: 0, y: 8)
                
                Spacer()
            }
            .padding()
            .navigationTitle("\(item.name) details")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    //TODO: Create helper 
    private func formattedPrice(with item: CryptoModelItem) -> String {
        let price = isCurrentCurrencyUSD ? item.pricingUSD.usd.price : item.pricingSEK.usd.price
        let currencyName = isCurrentCurrencyUSD ? "USD" : "SEK"
        return String(format: "%.4f", price) + " " + currencyName
    }
}

#Preview {
    CryptoDetailView(item: CryptoModelItem(id: 1, name: "Bitcoin", symbol: "BTC", description: "Jada jada...", pricingUSD: QuoteUSD(usd: QuoteData(price: 4.0, percentChange7d: 3.5)), pricingSEK: QuoteSEK(usd: QuoteData(price: 34, percentChange7d: 3.4))))
}
