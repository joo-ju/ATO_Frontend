//
//  Chat.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/16.
//

import Foundation
struct RoomModel: Decodable{
    let _id: String
    let sellerId: String
    let customerId: String
    let goodsId: String
    let isDeleted: Bool
}

struct ChatModel: Decodable {
    let _id: String
    let roomId: String
    let goodsId: String
    let content: Content
}

struct Content: Decodable, Hashable {
//    var id: ObjectIdentifier
    
    var userId: String
    var sendTime: String
    var message: String
}
