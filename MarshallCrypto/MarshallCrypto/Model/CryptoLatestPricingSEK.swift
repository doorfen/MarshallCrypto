//
//  CryptoLatestPricingSEK.swift
//  MarshallCrypto
//
//  Created by David Geijer on 2024-09-16.
//

import Foundation

struct CryptoLatestPricingSEK: Codable {
   let id: Int
   let name: String
   let last_update: String?
   let quote: QuoteSEK
}

struct QuoteSEK: Codable {
    let usd: QuoteData
    
    enum CodingKeys: String, CodingKey {
        case usd = "SEK"
    }
}
