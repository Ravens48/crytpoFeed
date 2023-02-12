//
//  PlistManager.swift
//  CryptoFeed
//
//  Created by Thomas ravens on 12/02/2023.
//

import Foundation

class PlistManager {
    let dict: NSDictionary
    
    init(ressourceName: String) {
        guard let filePath = Bundle.main.path(forResource: ressourceName, ofType: "plist"), let plist = NSDictionary(contentsOfFile: filePath) else {
            fatalError("could not file plist \(ressourceName) ")
        }
        self.dict = plist
    }
}

class ApiPlistManager {
    var api_url:String
    var plist: PlistManager
    init() {
        self.plist = PlistManager(ressourceName: "cryptoFeed-Info")
        self.api_url = self.plist.dict.object(forKey: "API_URL") as? String ?? ""
    }
}
