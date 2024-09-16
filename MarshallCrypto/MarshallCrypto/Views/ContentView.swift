//
//  ContentView.swift
//  MarshallCrypto
//
//  Created by David Geijer on 2024-09-13.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        UINavigationBar.appearance().backgroundColor = .clear
        UITableView.appearance().backgroundColor = UIColor.clear
        UITableViewCell.appearance().backgroundColor = UIColor.clear
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        
    }
    
    @Environment(FetchDataService.self) private var dataService
    // @Environment(\.currentCurrencyUSD) var isCurrentCurrencyUSD: Bool
    @State private var isCurrentCurrencyUSD: Bool = true
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                Color.appBackground
                    .ignoresSafeArea()
                LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .bottom)
                    .opacity(0.6)
                    .ignoresSafeArea()
                
                if (dataService.model.count > 0) {
                    
                    VStack {
                        List(dataService.model, id: \.id) { item in
                            NavigationLink(destination: CryptoDetailView(item: item)
                                .environment(\.currentCurrencyUSD, isCurrentCurrencyUSD))
                            {
                                VStack(alignment: .leading) {
                                    
                                    HStack {
                                        CryptoImage(cryptoId: item.id)
                                        
                                        VStack(alignment: .leading) {
                                            Text(item.name)
                                                .appFontSemiBold16()
                                                .foregroundStyle(.appText)
                                            
                                            Text(item.symbol)
                                                .appFontRegular16()
                                                .foregroundStyle(.appText)
                                        }.padding(.leading, 15)
                                        
                                        Spacer()
                                        
                                        VStack(alignment: .trailing) {
                                            Text(formattedPrice(with: item))
                                                .appFontRegular16()
                                                .foregroundStyle(.appText)
                                            Text("\(String(format: "%.3f", item.pricingUSD.usd.percentChange7d)) %")
                                                .appFontRegular16()
                                                .foregroundColor(item.pricingUSD.usd.percentChange7d >= 0 ? .green : .red)
                                            
                                        }
                                    }
                                }
                                .listRowBackground(Color.clear)
                                .padding([.top, .vertical], 8)
                                .shadow(color: .black, radius: 10, x: 0, y: 8)
                                .transition(.opacity)
                            }
                            .shadow(radius: 8, x: 2, y: 4)
                            .padding()
                            .listRowBackground(Color.clear)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [.blue, .purple]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(10)
                            
                        }
                        
                        .navigationTitle("Crypto tracker")
                        .navigationBarTitleDisplayMode(.inline)
                        .scrollContentBackground(.hidden)
                        .background(.clear)
                        .listRowBackground(Color.clear)
                        
                        Text("Changes the last seven days. Prices denoted in \(isCurrentCurrencyUSD ? "USD" : "SEK")")
                            .appFontSemiBold16()
                            .foregroundStyle(.appText)
                            .shadow(color: .black, radius: 10, x: 4, y: 2)
                        
                        Toggle("Currency \(isCurrentCurrencyUSD ? "USD" : "SEK")", isOn: $isCurrentCurrencyUSD)
                            .toggleStyle(SwitchToggleStyle(tint: .blue))
                            .foregroundStyle(.appText)
                            .padding([.leading, .trailing], 20)
                        
                    }
                    
                }
                else {
                    ProgressView()
                        .transition(.opacity)
                }
                
            }
            
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
    ContentView()
        .environment(FetchDataService())
}

#Preview("Darkmode") {
    ContentView()
        .environment(FetchDataService())
        .preferredColorScheme(.dark)
}
