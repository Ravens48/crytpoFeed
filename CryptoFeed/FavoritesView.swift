//
//  FavoritesView.swift
//  CryptoFeed
//
//  Created by Thomas ravens on 11/02/2023.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var cryptoModel = CryptoModel()
    @EnvironmentObject var userManager:UserManager
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Vos favoris")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.vertical, 10)
                CryptoRowsList(coinList: self.cryptoModel.favCoinList)
            }
        }
        .padding()
        .task {
            if let userId =  self.userManager.user?.id {
                await self.cryptoModel.fetchFavoriteCryptos(userId: userId, token: (self.userManager.user?.token)!, fiat: nil)
            }
        }
    }
}

struct CryptoRowsList:View {
    var coinList:[CoinModel] = []
    var body:some View {
        VStack(alignment: .leading) {
            Text("Coins")
                .font(.title2)
                .fontWeight(.semibold)
            HStack {
                Text("Coin")
                    .foregroundColor(.gray)
                Spacer()
                Text("Price")
                    .foregroundColor(.gray)
            }
            ForEach(coinList, id: \.self) { coin in
                CryptoRow(coin: coin)
//                    .environmentObject(userManager)
            }
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
