//
//  CreateAccountView.swift
//  CryptoFeed
//
//  Created by Thomas ravens on 15/02/2023.
//

import SwiftUI

struct CreateAccountView: View {
    @State var email:String = ""
    @State var name:String = ""
    @State var password: String  = ""
    @Binding var status:ProfilScreen
    @EnvironmentObject var userManager:UserManager
    var body: some View {
        VStack(alignment: .leading) {
            Text("Créer un compte")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("Créer un compte pour debloquer l'ensenble des fonctionnalités")
                .font(.title3)
                
            TextFieldComponent(picto: "envelope.fill", placeholder: "Email", inputValue: $email)
            TextFieldComponent(picto: "envelope.fill", placeholder: "Username", inputValue: $name)
            SecureFieldCompenent(password: $password)
            Button("Créer un compte", action: {
                print("create account")
                Task {
                    await self.userManager.createAccount(email: email, password: password, username: name)
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
            
            Button("J'ai déja un compte", action:{
                self.status = .connection
            })
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
