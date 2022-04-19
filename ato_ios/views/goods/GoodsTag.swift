//
//  Tag.swift
//  ato_ios
//
//  Created by 김주희 on 2021/09/15.
//  태그 #NCT 등

import Foundation
import SwiftUI

struct GoodsTag: View {
    let tag: String
    
    var body: some View {
        VStack(alignment: .leading){
            Text(tag)
                .padding(5)
                .foregroundColor(Color(hex: "375446"))
                .font(.system(size: 13))
        }
        .background(RoundedRectangle(cornerRadius: 20).stroke(Color(hex: "8EA4D2"), lineWidth: 2))
    }
}

struct MarketTag_Previews: PreviewProvider {
    static var previews: some View {
        GoodsTag(tag: "NCT")
    }
}

 
