//
//  FetchDataService.swift
//  MarshallCrypto
//
//  Created by David Geijer on 2024-09-13.
//

import Foundation

@Observable
class FetchDataService {
    
    private let apiKey = "d81c7c14-6da0-4abf-8d39-7c6307e581f8"
    private var cryptoResponse: CryptoResponse?
    
    static let shared = FetchDataService()
    
    private var cryptoModel: [CryptoData] = []
    private var latestPricingUSD: [CryptoLatestPricingUSD] = []
    private var latestPricingSEK: [CryptoLatestPricingSEK] = []
    
    var model: [CryptoModelItem] = []
    
    func createModel() async {
        
        // CoinMarketCap only allows one convertion per call when using the basic plans. Thats why i make two requests here.
        
        await fetchCryptoInfo()
        await fetchCryptoLatestPricingUSD()
        await fetchCryptoLatestPricingSEK()
        await constructModel()
    }
    
    func constructModel() async {
        
        var model: [CryptoModelItem] = []
        
        cryptoModel.forEach { item in
            
            let id = item.id
            let name = item.name
            let symbol = item.symbol
            
            guard let description = item.description else { return }
            guard let pricingUSD = latestPricingUSD.filter({ $0.id == item.id}).first?.quote else { return }
            guard let pricingSEK = latestPricingSEK.filter({ $0.id == item.id}).first?.quote else { return }
            
            let cryptoModelItem = CryptoModelItem(id: id, name: name, symbol: symbol, description: description, pricingUSD: pricingUSD, pricingSEK: pricingSEK)
            model.append(cryptoModelItem)
        }
        
        self.model = model
        
        
    }
    
    private func fetchCryptoLatestPricingUSD() async {
        
        guard let urlUSD = URL(string: "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?convert=USD") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: urlUSD)
        request.setValue(apiKey, forHTTPHeaderField: "X-CMC_PRO_API_KEY")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Invalid response: \(response)")
                return
            }
            
            
            let cryptoResponseLatestPricing = try JSONDecoder().decode(CryptoResponseLatestPricingUSD.self, from: data)
            
            let targetIDs = [1, 1027, 825, 1839, 5426]
            latestPricingUSD = Array(cryptoResponseLatestPricing.data).filter { targetIDs.contains($0.id) }
            
            print(latestPricingUSD)
            
            
        } catch {
            // Handle any errors during the fetch or decoding process
            print("Error fetching data: \(error.localizedDescription)")
        }
        
    }
    
    private func fetchCryptoLatestPricingSEK() async {
        
        guard let urlSEK = URL(string: "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?convert=SEK") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: urlSEK)
        request.setValue(apiKey, forHTTPHeaderField: "X-CMC_PRO_API_KEY")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Invalid response: \(response)")
                return
            }
            
            
            let cryptoResponseLatestPricingSEK = try JSONDecoder().decode(CryptoResponseLatestPricingSEK.self, from: data)
            
            let targetIDs = [1, 1027, 825, 1839, 5426]
            latestPricingSEK = Array(cryptoResponseLatestPricingSEK.data).filter { targetIDs.contains($0.id) }
            
            print(latestPricingSEK)
            
            
        } catch {
            // Handle any errors during the fetch or decoding process
            print("Error fetching data: \(error.localizedDescription)")
        }
        
    }
    
    private func fetchCryptoInfo() async {
        
        guard let url = URL(string: "https://pro-api.coinmarketcap.com/v2/cryptocurrency/info?id=1,1027,825,1839,5426") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-CMC_PRO_API_KEY")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Invalid response: \(response)")
                return
            }
            
            cryptoResponse = try JSONDecoder().decode(CryptoResponse.self, from: data)
            print("Crypto info fetched.")
            
            
            if let cryptoResponse = cryptoResponse {
                cryptoModel = convertToCryptoInfo(response: cryptoResponse)
                print("Crypto model created.")
            }
            
        } catch {
            // Handle any errors during the fetch or decoding process
            print("Error fetching data: \(error.localizedDescription)")
        }
    }
    
    private func convertToCryptoInfo(response: CryptoResponse) -> [CryptoData] {
        
        return Array(response.data.values)
        
    }
}

