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
                ConnectedUserView(status: $statusPage)
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

struct ProfilView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilView(statusPage: .connected)
            .environmentObject(UserManager())
    }
}
