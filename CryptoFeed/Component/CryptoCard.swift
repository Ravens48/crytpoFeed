//
//  CryptoCard.swift
//  CryptoFeed
//
//  Created by Thomas ravens on 02/02/2023.
//

import SwiftUI

struct CryptoCard: View {
    var body: some View {
        VStack(alignment:.leading){
            Image(systemName: "bitcoinsign.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(.orange)
            HStack {
                Text("BTC")
                Text("$33")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Text("-5,5%")
                .font(.title2)
                .foregroundColor(.green)
        }
        .padding(.horizontal, 40)
        .padding(.vertical, 20)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray4), lineWidth: 2)
        )
    }
}

struct CryptoCard_Previews: PreviewProvider {
    static var previews: some View {
        CryptoCard()
    }
}
