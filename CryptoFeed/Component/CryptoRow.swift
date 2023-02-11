//
//  CryptoRow.swift
//  CryptoFeed
//
//  Created by Thomas ravens on 02/02/2023.
//

import SwiftUI

struct CryptoRow: View {
    var coin:CoinModel
//    @EnvironmentObject var userManager:UserManager
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
                    Text("$\(coin.currentPrice)")
                    Text("\(coin.priceChange24H ?? 0)")
                        .foregroundColor(coin.priceChange24H ?? 0 > 0 ? .green : .red)
                }
                //            if userManager.user?.id != nil {
                //                Image(systemName: "heart")
                //            }
            }
        .padding(.vertical, 10)
        .padding(.horizontal, 4)
    }
}

//struct CryptoRow_Previews: PreviewProvider {
//    static var previews: some View {
//        CryptoRow(coin: CoinModel)
//    }
//}
