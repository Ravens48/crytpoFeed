//
//  TexFieldComponent.swift
//  CryptoFeed
//
//  Created by Thomas ravens on 15/02/2023.
//

import SwiftUI

struct TextFieldComponent:View {
    let picto:String
    let placeholder:String
    @Binding var inputValue:String
    var body: some View {
        HStack {
            Image(systemName: picto)
                .resizable()
                .frame(width: 20, height: 20)
                .padding(.horizontal, 10)
            TextField(self.placeholder, text: $inputValue)
                .onChange(of: inputValue) { text in
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
