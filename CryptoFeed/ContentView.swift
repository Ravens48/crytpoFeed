//
//  ContentView.swift
//  CryptoFeed
//
//  Created by Thomas ravens on 02/02/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            Text("Live View")
                .font(.title)
                .fontWeight(.semibold)
                .padding(10)
            VStack(alignment: .leading) {
                Text("Top movers")
                    .font(.title2)
                    .fontWeight(.semibold)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing:20) {
                        ForEach(0..<10) {_ in
                            CryptoCard()
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
                ForEach(0..<10) { _ in
                    CryptoRow()
                }
                Spacer()
            }
        }
        .padding()
        .edgesIgnoringSafeArea(.bottom)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
