//
//  LiveCryptoView.swift
//  CryptoFeed
//
//  Created by Thomas ravens on 11/02/2023.
//

import SwiftUI

struct CryptoLiveView: View {
    @ObservedObject var cryptoModel:CryptoModel
    @EnvironmentObject var userManager:UserManager
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("Live View")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(10)
                VStack(alignment: .leading) {
                    if (userManager.user?.username) != nil {
                        Text("Hello, \(userManager.user?.username ?? "")")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                    Text("Top movers")
                        .font(.title2)
                        .fontWeight(.semibold)
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing:20) {
                            ForEach(self.cryptoModel.topMovingCoins, id: \.self) { coin in
                                CryptoCard(coin:coin)
                            }
                        }
                    }
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
                    ForEach(self.cryptoModel.coinList, id: \.self) { coin in
                        NavigationLink(destination: CryptoSingleView(coin: coin)
                            .toolbar(.hidden, for: .tabBar)
                            .environmentObject(self.userManager)
                        ) {
                            CryptoRow(coin: coin)
                                .accentColor(Color.black)
                                .environmentObject(userManager)
                        }
                        
                    }
                    Spacer()
                }
            }
        }
        .padding()
        .edgesIgnoringSafeArea(.bottom)
    }
}

//struct CryptoLiveView_Previews: PreviewProvider {
//    static var previews: some View {
//        CryptoLiveView(cryptoModel: CryptoModel())
//    }
//}
