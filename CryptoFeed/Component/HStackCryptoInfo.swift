//
//  HStackCryptoInfo.swift
//  CryptoFeed
//
//  Created by Thomas ravens on 15/02/2023.
//

import Foundation
import SwiftUI

struct HStackCryptoInfo:View {
    var infoTitle1:String
    var info1:String
    var infoTitle2:String
    var info2:String
    var body:some View {
        HStack() {
            VStack(alignment: .leading) {
                Text("\(infoTitle1)")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(1)
                Text("\(info1)")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.systemGray4), lineWidth: 2)
            )
            VStack(alignment: .trailing) {
                Text(infoTitle2)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(1)
                Text(info2)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.systemGray4), lineWidth: 2)
            )
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 5)
    }
}
