//
//  UserHistory.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/13.
//

import Foundation

struct UserHistoryModel: Decodable {
    let _id: String
    let userId:String
    let wishGoods: Array<String>
    let chatRooms: Array<RoomModel>
}
