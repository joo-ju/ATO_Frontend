//
//  ReviewGoods.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/10.
//

import Foundation

struct ReviewGoodsModel: Decodable {
    let _id:String
    let writer: String
    let goodsId: String
    let content: String
    let score: Int
//    let enrollTime: Date
//    let updateTime: Date
}
