//
//  UserRegister.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/12.
//

import Foundation
struct UserRegisterModel: Decodable {
    let _id:String
    let username: String
    let password: String
    let name: String
    let nickname: String
    let email: String
    let phone: Int
    let score: Int
    let count: Int
//    let enrollTime: Date
//    let updateTime: Date
}
struct UserModel: Decodable {
    let user:User
}

struct User: Decodable {
    var id:String
    var username:String
    let authorized: Bool
}
