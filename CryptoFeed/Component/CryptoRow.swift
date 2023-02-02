//
//  CryptoRow.swift
//  CryptoFeed
//
//  Created by Thomas ravens on 02/02/2023.
//

import SwiftUI

struct CryptoRow: View {
    var body: some View {
        HStack {
            Text("1")
                .font(.caption)
                .foregroundColor(.gray)
            Image(systemName: "bitcoinsign.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
                .foregroundColor(.orange)
            VStack(alignment: .leading) {
                Text("Bitcoin")
                Text("BTC")

                    .foregroundColor(.gray)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("$333344")
                Text("-5,5%")
                    
            }
            Image(systemName: "heart")
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 4)
    }
}

struct CryptoRow_Previews: PreviewProvider {
    static var previews: some View {
        CryptoRow()
    }
}
