//
//  UserModel.swift
//  CryptoFeed
//
//  Created by Thomas ravens on 05/02/2023.
//

import SwiftUI
import Foundation

struct UserModel: Codable, Hashable {
    let id : String
    let username : String?
    let password: String?
    let email : String
    let token : String?
    let source : String
    let roles: String?
    let cryptoFavs: [String]?

    enum CodingKeys: String, CodingKey {
        case id, username, password, email, token, source, roles, cryptoFavs
    }
    
}

struct MyJsonUser: Encodable {
    let email: String
    let username: String?
    let password: String
}

struct ConnectUser: Encodable {
    let email:String
    let password: String
}

struct ErrorResponse: Decodable {
    let token:String?
    let message: String
}


class UserManager: ObservableObject {
    // environement object ?
    @Published var user:UserModel? = nil
    
    
    func createAccount(email:String, password:String, username:String) async {
        let user = MyJsonUser(email: email, username: username, password: password)
        guard let url = URL(string: "http://localhost:3000/api/auth/signup") else {
            return
        }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let payload = try? JSONEncoder().encode(user)
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: payload!)
            if let userData = try? JSONDecoder().decode(UserModel.self, from: data) {
                DispatchQueue.main.async {
                    self.user = userData
                }
            }
        } catch {
            print("error fetching data\(error)")
        }
    }
    
    func connectAccount(email:String, password:String) async {
        let user = ConnectUser(email: email, password: password)
        guard let url = URL(string: "http://localhost:3000/api/auth/signin") else {
            return
        }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let payload = try? JSONEncoder().encode(user)
        
        do {
            let (data, response) = try await URLSession.shared.upload(for: request, from: payload!)
            if let userData = try? JSONDecoder().decode(UserModel.self, from: data) {
                DispatchQueue.main.async {
                    self.user = userData
                }
            } else {
                print(response)
                if let errorReponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                    print("error", errorReponse)
                }
            }
        } catch {
            print("error fetching data\(error)")
        }

    }
}
