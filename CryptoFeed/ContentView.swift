//
//  ContentView.swift
//  CryptoFeed
//
//  Created by Thomas ravens on 02/02/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var cryptoModel = CryptoModel()
    @StateObject private var userManager = UserManager()
    var body: some View {
        TabView {
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
                        CryptoRow(coin: coin)
                            .environmentObject(userManager)
                    }
                    Spacer()
                }
            }
            .padding()
            .edgesIgnoringSafeArea(.bottom)
            .environmentObject(userManager)
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            ProfilView(statusPage: .createAccount)
                .environmentObject(userManager)
                .tabItem {
                    Image(systemName: "house")
                    Text("Profil")
                }
        }
        .task {
            await cryptoModel.fetchCryptos(fiat: nil)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
