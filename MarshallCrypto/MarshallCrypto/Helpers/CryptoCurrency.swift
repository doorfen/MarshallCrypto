//
//  CryptoCurrency.swift
//  MarshallCrypto
//
//  Created by David Geijer on 2024-09-13.
//

import Foundation

enum CryptoCurrency: Int {
    case BTC = 1      // Bitcoin
    case ETH = 1027   // Ethereum
    case USDT = 825   // Tether
    case BNB = 1839   // Binance Coin
    case SOL = 5426   // Solana
    
    var description: String {
        switch self {
        case .BTC:
            return "Bitcoin"
        case .ETH:
            return "Ethereum"
        case .USDT:
            return "Tether"
        case .BNB:
            return "Binance Coin"
        case .SOL:
            return "Solana"
        }
    }
}
