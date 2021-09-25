//
//  MarketSearchScreen.swift
//  ato_ios
//
//  Created by 김주희 on 2021/09/17.
//  하단 탭에서 search를 선택했을 때 보여지는 뷰

import Foundation
import SwiftUI

struct SearchScreen : View {
    @State var tabIndex = 0
    //    @Binding var tabIndex: Int
    var body: some View {
    
        VStack{
            MarketMainSearch()
            TopBar(tabIndex: $tabIndex)
            if tabIndex == 0 {
                MarketSearchTab()
            }
            else {
                EventSearchTab()
            }
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 24, alignment: .center)
        .padding(.horizontal, 12)
    }
}

//
struct SearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreen()
    }
}
