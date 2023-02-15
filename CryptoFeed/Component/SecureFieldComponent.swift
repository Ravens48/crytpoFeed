//
//  SecureFieldComponent.swift
//  CryptoFeed
//
//  Created by Thomas ravens on 15/02/2023.
//

import SwiftUI

struct SecureFieldCompenent:View {
    @Binding var password:String
    var body: some View {
        HStack {
            Image(systemName: "lock.fill")
                .resizable()
                .frame(width: 20, height: 25)
                .padding(.horizontal, 10)
            SecureField("Password", text: $password)
                .onChange(of: password) { text in
                }
                .multilineTextAlignment(.leading)
                .frame(height: 55)
                .textFieldStyle(PlainTextFieldStyle())
        }
        .background(Color(.systemGray4))
        .cornerRadius(12)
        .padding(.vertical, 10)

    }
}
