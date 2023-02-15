//
//  ConnectionView.swift
//  CryptoFeed
//
//  Created by Thomas ravens on 15/02/2023.
//

import SwiftUI

struct ConnectionView: View {
    @State var email:String = ""
    @State var password: String  = ""
    @Binding var status:ProfilScreen
    @EnvironmentObject var userManager:UserManager

    var body: some View {
        VStack(alignment: .leading) {
            Text("Me connecter")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("Ce un compte pour debloquer l'ensenble des fonctionnalités")
                .font(.title3)
                
            TextFieldComponent(picto: "envelope.fill", placeholder: "Email", inputValue: $email)
            SecureFieldCompenent(password: $password)
            Button("Me connecter",
                   action:{
                print("test")
                Task {
                    await self.userManager.connectAccount(email: email, password: password)
                    if (userManager.user?.token) != nil {
                        self.status = .connected
                    }
                }
                
            })
            .foregroundColor(.white)
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(15)
            .font(.system(size: 17, weight: .bold))
            .background(Color(.systemBlue))
            .cornerRadius(12)
            .padding(.vertical, 15)
            
            Button("Crée un compte", action:{self.status = .createAccount})
                .foregroundColor(Color(.systemBlue))
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(15)
            .font(.system(size: 17, weight: .bold))
            .background(.white)
            .cornerRadius(12)
            .padding(.vertical, 15)
            
            Spacer()

        }
        .padding(.horizontal, 20)
    }
}
