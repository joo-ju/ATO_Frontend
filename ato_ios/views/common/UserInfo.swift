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
    
//    @Published var isPrivate: Bool {
//        didSet {
//            UserDefaults.standard.set(isPrivate, forKey: "isAccountPrivate")
//        }
//    }
//
//    @Published var ringtone: String {
//        didSet {
//            UserDefaults.standard.set(ringtone, forKey: "ringtone")
//        }
//    }
    
//    public var ringtones = ["Chimes", "Signal", "Waves"]
    
    init() {
        self.username = UserDefaults.standard.object(forKey: "username") as? String ?? ""
//        self.isPrivate = UserDefaults.standard.object(forKey: "isAccountPrivate") as? Bool ?? true
//        self.ringtone = UserDefaults.standard.object(forKey: "ringtone") as? String ?? "Chimes"
        self.id = UserDefaults.standard.object(forKey: "id") as? String ?? ""
    }
}
