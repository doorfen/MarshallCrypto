//
//  MarshallCryptoApp.swift
//  MarshallCrypto
//
//  Created by David Geijer on 2024-09-13.
//

import SwiftUI

@main
struct MarshallCryptoApp: App {
    
    @State private var dataService = FetchDataService.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    await dataService.createModel()
                }
        }
        .environment(dataService)
        .environment(\.currentCurrencyUSD, true)
    }
}
