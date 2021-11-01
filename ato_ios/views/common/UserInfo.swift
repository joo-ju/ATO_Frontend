//
//  UserSetting.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/12.
//

import Foundation
import Combine

class UserInfo: ObservableObject {
    @Published var username: String {
        didSet {
            UserDefaults.standard.set(username, forKey: "username")
        }
    }
    
    @Published var id: String {
        didSet {
            UserDefaults.standard.set(id, forKey: "id")
        }
    }
    
    @Published var wallet: String {
        didSet {
            UserDefaults.standard.set(wallet, forKey: "wallet")
        }
    }

    init() {
        self.username = UserDefaults.standard.object(forKey: "username") as? String ?? ""
        self.id = UserDefaults.standard.object(forKey: "id") as? String ?? ""
        self.wallet = UserDefaults.standard.object(forKey: "wallet") as? String ?? ""
    }
}
