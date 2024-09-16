//
//  CryptoResponse.swift
//  MarshallCrypto
//
//  Created by David Geijer on 2024-09-13.
//

import Foundation

struct CryptoResponse: Codable {
    let data: [String: CryptoData]
}

struct CryptoResponseLatestPricingUSD: Codable {
    let data: [CryptoLatestPricingUSD]
}

struct CryptoResponseLatestPricingSEK: Codable {
    let data: [CryptoLatestPricingSEK]
}
