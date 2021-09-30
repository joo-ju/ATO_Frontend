//
//  Event.swift
//  ato_ios
//
//  Created by 김주희 on 2021/09/29.
//

import Foundation

struct Event: Codable {
    var id: String
    var name: String
    var categoryId: String
    var discription: String
    var sellerId: String
    var age: Int
    var price : Int
    var score: Int
    var count: Int
    var showDateTime: Date
    var showAmount: Int
    var enrollTime: Date
    var updateTime: Date
    var deleteTime: Date
}
