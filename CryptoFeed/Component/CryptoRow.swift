//
//  CryptoRow.swift
//  CryptoFeed
//
//  Created by Thomas ravens on 02/02/2023.
//

import SwiftUI

struct CryptoRow: View {
    var coin:CoinModel
    var body: some View {
            HStack {
                Text("1")
                    .font(.caption)
                    .foregroundColor(.gray)
                ImageFromUrl(urlImage: coin.image, width: nil, height: nil)
                VStack(alignment: .leading) {
                    Text(coin.name)
                    Text(coin.symbol)
                    
                        .foregroundColor(.gray)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("$\(round(coin.currentPrice * 1000) / 1000)")
                    Text("\(round(coin.priceChange24H ?? 0 * 100) / 100 )")
                        .foregroundColor(coin.priceChange24H ?? 0 > 0 ? .green : .red)
                }
            }
        .padding(.vertical, 10)
        .padding(.horizontal, 4)
    }
}

