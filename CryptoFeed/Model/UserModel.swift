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
    var cryptosFav: [String]?

    enum CodingKeys: String, CodingKey {
        case id, username, password, email, token, source, roles, cryptosFav
    }
    
}

struct MyJsonUser: Encodable {
    let email: String
    let username: String?
    let password: String
}

struct CryptoUpdate: Encodable {
    let cryptoId: String
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
    @Published var user:UserModel? = nil
    let api_url = ApiPlistManager().api_url
    
    func getUser() async {
        let userDefaults = UserDefaults.standard
        let userId = userDefaults.string(forKey: "userId")
        if let userId = userId {
            guard let url = URL(string: "\(self.api_url)api/user/\(userId)") else {
                return
            }
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let user = try? JSONDecoder().decode(UserModel.self, from: data) {
                    DispatchQueue.main.async {
                        self.user = user
                    }
                } else {
                    print("debug failed")
                }
            } catch {
                print("error fecthing data \(error)")
            }
        } else {
            DispatchQueue.main.async {
                self.user = nil
            }
        }
    }
    
    func createAccount(email:String, password:String, username:String) async {
        let user = MyJsonUser(email: email, username: username, password: password)
        guard let url = URL(string: "\(self.api_url)api/auth/signup") else {
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
                    let userDefaults = UserDefaults.standard
                    userDefaults.setValue(self.user?.id, forKey: "userId")
                    userDefaults.synchronize()
                }
            }
        } catch {
            print("error fetching data\(error)")
        }
    }
    
    func connectAccount(email:String, password:String) async {
        let user = ConnectUser(email: email, password: password)
        guard let url = URL(string: "\(self.api_url)api/auth/signin") else {
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
                    let userDefaults = UserDefaults.standard
                    userDefaults.setValue(self.user?.id, forKey: "userId")
                    userDefaults.synchronize()
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
    
    func updateCryptosFav(userId:String ,cryptoId:String) async {
        let crypto = CryptoUpdate(cryptoId: cryptoId)
        guard let url = URL(string: "\(self.api_url)api/user/crypto/\(userId)") else {
            return
        }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PUT"
        let payload = try? JSONEncoder().encode(crypto)

        do {
            let (data, response) = try await URLSession.shared.upload(for: request, from: payload!)
            if let favs = try? JSONDecoder().decode([String]?.self, from: data) {
                DispatchQueue.main.async {
                    self.user?.cryptosFav = favs
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
    
    func disconnectuser() {
        DispatchQueue.main.async {
            let userDefaults = UserDefaults.standard
            userDefaults.setValue(nil, forKey: "userId")
            self.user = nil
            userDefaults.synchronize()
        }
    }
}
