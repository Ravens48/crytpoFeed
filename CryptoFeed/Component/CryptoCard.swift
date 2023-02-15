//
//  CryptoCard.swift
//  CryptoFeed
//
//  Created by Thomas ravens on 02/02/2023.
//

import SwiftUI

struct CryptoCard: View {
    let coin:CoinModel
    var body: some View {
        VStack(alignment:.leading){

            ImageFromUrl(urlImage: coin.image, width: nil, height: nil)
            HStack {
                Text(coin.symbol)
                Text("\((round((coin.priceChangePercentage24H ?? 0.0) * 100) / 100) )")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Text("\(coin.currentPrice)")
                .font(.title2)
                .foregroundColor(.green)
        }
        .frame(width: 140, height: 140)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray4), lineWidth: 2)
        )
    }
}
