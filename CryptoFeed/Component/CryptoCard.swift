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
                Text("\(coin.priceChangePercentage24H ?? 0.0)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Text("\(coin.currentPrice)")
                .font(.title2)
                .foregroundColor(.green)
        }
//        .padding(.horizontal, 40)
//        .padding(.vertical, 20)
        .frame(width: 140, height: 140)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray4), lineWidth: 2)
        )
    }
}

//struct CryptoCard_Previews: PreviewProvider {
//    static var previews: some View {
//        CryptoCard()
//    }
//}
