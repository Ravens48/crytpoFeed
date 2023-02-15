//
//  CryptoSingleView.swift
//  CryptoFeed
//
//  Created by Thomas ravens on 11/02/2023.
//

import SwiftUI

struct CryptoSingleView: View {
    var coin:CoinModel
    @State var imageHeartStatus = "heart"
    @State var statusFav:Bool = false
    @EnvironmentObject var userManager:UserManager
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ImageFromUrl(urlImage:coin.image, width: 100, height: 100)
                    .frame(maxWidth: .infinity, alignment: .center)
                HStack(spacing: 20) {
                    Text("\(self.coin.name)")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(systemName: statusFav ? "heart.fill" : "heart" )
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.red)
                        .frame(width: 30, height: 30)
                        .onTapGesture {
                            Task {
                                if let userId = self.userManager.user?.id {
                                    await self.userManager.updateCryptosFav(userId:userId, cryptoId:self.coin.symbol)
                                }
                                
                            }
                            self.statusFav = !self.statusFav
                        }
                }
                HStackCryptoInfo(infoTitle1: "Current price", info1: "\(coin.currentPrice)", infoTitle2: "ATH price", info2: "\(coin.marketCap ?? 100)")
                HStackCryptoInfo(infoTitle1: "High 24h", info1: "\(coin.high24H ?? 100)", infoTitle2: "Low 24h", info2: "\(coin.low24H ?? 100)")
                HStackCryptoInfo(infoTitle1: "Market cap", info1: "\(coin.marketCap ?? 100)", infoTitle2: "Total volume", info2: "\(coin.totalVolume ?? 100)")
                Text("Developper informations :")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.vertical, 20)
                HStack() {
                    Text("Forks: ")
                        .fontWeight(.semibold)
                        .padding(5)
                        .background(.blue)
                        .cornerRadius(10)
                    Text("33761")
                }
                HStack() {
                    Text("Total issue: ")
                        .fontWeight(.semibold)
                        .padding(5)
                        .background(.orange)
                        .cornerRadius(10)
                    Text("33761")
                }
                HStack() {
                    Text("Closed issue: ")
                        .fontWeight(.semibold)
                        .padding(5)
                        .background(.green)
                        .cornerRadius(10)
                    Text("33761")
                }
                Spacer()
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .task {
            if let user = self.userManager.user  {
                self.statusFav = user.cryptosFav!.contains(self.coin.symbol)
            }
        }
    }
}


struct CryptoSingleView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoSingleView(coin: CoinModel(id: "Bitcoin", symbol: "btc", name: "Bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579", currentPrice: 222234, marketCap: 21211212311, marketCapRank: 1, fullyDilutedValuation: nil, totalVolume: nil, high24H: 23332, low24H: 23331, priceChange24H: nil, priceChangePercentage24H: nil, marketCapChange24H: nil, marketCapChangePercentage24H: nil, circulatingSupply: nil, totalSupply: nil, maxSupply: nil, ath: 57009, athChangePercentage: nil, athDate: nil, atl: nil, atlChangePercentage: nil, atlDate: nil, lastUpdated: "23/01/2023"))
    }
}
