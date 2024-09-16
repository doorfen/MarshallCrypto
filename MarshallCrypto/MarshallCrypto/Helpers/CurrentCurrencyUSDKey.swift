//
//  CurrentCurrencyUSDKey.swift
//  MarshallCrypto
//
//  Created by David Geijer on 2024-09-16.
//

import SwiftUI

struct CurrentCurrencyUSDKey: EnvironmentKey {
    static let defaultValue: Bool = true
}

extension EnvironmentValues {
    var currentCurrencyUSD: Bool {
        get { self[CurrentCurrencyUSDKey.self] }
        set { self[CurrentCurrencyUSDKey.self] = newValue }
    }
}
