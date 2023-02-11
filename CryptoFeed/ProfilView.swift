//
//  ProfilView.swift
//  CryptoFeed
//
//  Created by Thomas ravens on 04/02/2023.
//

import SwiftUI

enum ProfilScreen {
    case connected
    case createAccount
    case connection
}

struct ProfilView:View {
    @EnvironmentObject var userManager:UserManager
    @State var statusPage:ProfilScreen
    var body:some View {
        VStack {
            switch statusPage {
            case .createAccount:
                CreateAccountView(status: $statusPage)
                    .environmentObject(userManager)
            case .connection:
                ConnectionView(status: $statusPage)
                    .environmentObject(userManager)
            case .connected:
                ConnectedUser()
                    .environmentObject(userManager)

            }
        }
        .onAppear{
            if userManager.user?.id != nil {
                self.statusPage = .connected
            } else {
                self.statusPage = statusPage
            }            
        }
    }
}

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


struct ConnectedUser: View {
    @EnvironmentObject var userManager:UserManager
    var body: some View {
        VStack {
            Text(userManager.user?.username ?? "FAIL?")
        }
    }
}


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
                    print("passe")
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

struct SecureFieldCompenent:View {
    @Binding var password:String
    var body: some View {
        HStack {
            Image(systemName: "lock.fill")
                .resizable()
                .frame(width: 20, height: 25)
                .padding(.horizontal, 10)
            TextField("Password", text: $password)
                .onChange(of: password) { text in
                    print("passe")
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

struct ProfilView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilView(statusPage: .createAccount)
    }
}
