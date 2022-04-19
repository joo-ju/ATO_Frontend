//
//  Wallet.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/31.
//

import Foundation

struct WalletModel: Decodable {
    let _id: String
    let userId: String
    let balance: Int
    let enrollTime: String
    let updateTime: String
}

struct WalletContentModel: Decodable {
    let _id: String
    let cost: Int
    let type: String
    let enrollTime: String
}
