//
//  CryptoData.swift
//  MarshallCrypto
//
//  Created by David Geijer on 2024-09-13.
//

import Foundation

struct CryptoModelItem: Identifiable {
    let id: Int
    let name: String
    let symbol: String
    let description: String
    let pricingUSD: QuoteUSD
    let pricingSEK: QuoteSEK
}

struct CryptoData: Codable, Identifiable {
    let id: Int
    let name: String
    let symbol: String
    let category: String?
    let description: String?
}

