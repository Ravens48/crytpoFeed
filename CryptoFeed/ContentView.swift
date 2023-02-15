//
//  ContentView.swift
//  CryptoFeed
//
//  Created by Thomas ravens on 02/02/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var cryptoModel = CryptoModel()
    @ObservedObject private var userManager = UserManager()
    var body: some View {
        TabView {
            CryptoLiveView(cryptoModel: self.cryptoModel)
                .environmentObject(self.userManager)
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            if (self.userManager.user?.id != nil ) {
                FavoritesView()
                    .environmentObject(self.userManager)
                    .tabItem {
                        Image(systemName: "heart")
                        Text("Favoris")
                    }
            }
            ProfilView(statusPage: .connection)
                .environmentObject(self.userManager)
                .tabItem {
                    Image(systemName: "person")
                    Text("Profil")
                }
        }
        .task {
            await userManager.getUser()
            await cryptoModel.fetchCryptos(fiat: nil)
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
