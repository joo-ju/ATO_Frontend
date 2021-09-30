//
//  testModel.swift
//  ato_ios
//
//  Created by 김주희 on 2021/09/25.
//

import Foundation

struct DataModel: Decodable {
//    let error: Bool
//    let message: String
    let data: [PostModel]
}

struct PostModel: Decodable {
    let _id:String
    let title: String
    let post: String
//    let enrollTime: Date
//    let updateTime: Date
}

struct Model: Decodable {
    let id: Int
    let userId: Int
    let title: String
    let completed: Bool
}
 
