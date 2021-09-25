//
//  MainSearchBar.swift
//  ato_ios
//
//  Created by 김주희 on 2021/09/16.
//

import Foundation
import SwiftUI

struct MarketMainSearch: View {
    @State var keyword:String = ""
    var body: some View {

        VStack{
        TextField("검색어를 입력해주세요.", text: $keyword)
            .padding()
            .padding(.leading, 10)
            .background(Color(hex: "F0F4FF"))
            .clipShape(RoundedRectangle(cornerRadius: 50), style: /*@START_MENU_TOKEN@*/FillStyle()/*@END_MENU_TOKEN@*/)

        } // end VStack
        .padding([.leading, .trailing], 10)
        .padding(.top, 20)
    }
}
struct MarketMainSearch_Previews: PreviewProvider {
    static var previews: some View {
        MarketMainSearch()
    }
}
