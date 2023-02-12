//
//  CryptoModel.swift
//  CryptoFeed
//
//  Created by Thomas ravens on 03/02/2023.
//

import SwiftUI

class CryptoModel:ObservableObject {
 
    @Published var coinList:[CoinModel] = []
    @Published var topMovingCoins:[CoinModel] = []
    @Published var favCoinList:[CoinModel] = []
    let api_url = ApiPlistManager().api_url

    
    func fetchCryptos(fiat:String?) async {
        guard let url = URL(string: "\(self.api_url)api/crypto/usd/100") else {
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let coins = try? JSONDecoder().decode([CoinModel].self, from: data) {
                DispatchQueue.main.async {
                    self.coinList = coins
                    self.setupTopMovingCoins()
                }
            } else {
                print("debug failed")
            }
        } catch {
            print("error fecthing data \(error)")
        }
    }
    
    func fetchFavoriteCryptos(userId:String, token:String,fiat:String?) async {
        guard let url = URL(string: "\(self.api_url)api/cryptos/favs/\(userId)") else {
            return
        }
        var request = URLRequest(url:url)
        request.allHTTPHeaderFields = ["x-access-token": token]
        request.httpMethod = "GET"
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            if let coins = try? JSONDecoder().decode([CoinModel].self, from: data) {
                DispatchQueue.main.async {
                    self.favCoinList = coins
                }
            } else {
                print("debug failed")
            }
        } catch {
            print("error fecthing data \(error)")
        }    }
    
    func setupTopMovingCoins() {
        let top = self.coinList.sorted(by: {$0.priceChangePercentage24H ?? 0 > $1.priceChangePercentage24H ?? 0})
        self.topMovingCoins = Array(top.prefix(10))
    }
}
