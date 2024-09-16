//
//  CryptoLatestPricingUSD.swift
//  MarshallCrypto
//
//  Created by David Geijer on 2024-09-16.
//

import Foundation

struct CryptoLatestPricingUSD: Codable {
   let id: Int
   let name: String
   let last_update: String?
   let quote: QuoteUSD
}

struct QuoteUSD: Codable {
    let usd: QuoteData
    
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
    }
}

struct QuoteData: Codable {
    let price: Double
    let percentChange7d: Double
  
    enum CodingKeys: String, CodingKey {
        case price
        case percentChange7d = "percent_change_7d"
    }
}
