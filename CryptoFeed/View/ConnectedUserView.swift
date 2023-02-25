//
//  ConnectedUserView.swift
//  CryptoFeed
//
//  Created by Thomas ravens on 15/02/2023.
//

import SwiftUI

struct ConnectedUserView: View {
    @EnvironmentObject var userManager:UserManager
    @Binding var status:ProfilScreen
    var body: some View {
        VStack{
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 80, height: 80)
            VStack(alignment: .leading) {
                Text("Username:")
                    .font(.title2)
                    .fontWeight(.light)
                Text(userManager.user?.username ?? "TestUser")
                    .font(.title)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
            VStack(alignment: .leading) {
                Text("Email:")
                    .autocapitalization(.none)
                    .font(.title2)
                    .fontWeight(.light)
                Text(userManager.user?.email ?? "test@gmail.com")
                    .font(.title)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
            Spacer()
            Button("Disconnect", action:{
                print("deconnection")
                self.userManager.disconnectuser()
                self.status = .connection
            })
                .foregroundColor(.white)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(15)
                .font(.system(size: 17, weight: .bold))
                .background(Color(.systemBlue))
                .cornerRadius(12)
                .padding(.vertical, 15)

        }
        .padding(.horizontal, 20)
    }
}
