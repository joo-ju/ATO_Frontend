//
//  BottomBar.swift
//  ato_ios
//
//  Created by 김주희 on 2021/09/10.
//

import SwiftUI

struct BottomBar: View {
    enum TabItems {case marketHome, search, myAto, chat}
    @State private var selectedTab = 0          // 상태를 저장할 프로퍼티 정의

    var body: some View {
        TabView(selection: $selectedTab){
            Text("Main Screen")
                .font(.largeTitle)
                .tag(TabItems.marketHome)
                .tabItem {
                    Image(systemName: "house")
                    Text("홈")
                }
            Text("Search Screen")
                .font(.largeTitle)
                .tag(TabItems.search)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("검색")
                }
            Text("Chat Screen")
                .font(.largeTitle)
                .tag(TabItems.chat)
                .tabItem {
                    Image(systemName: "message")
                    Text("채팅")
                }
            Login()
                .tabItem {
                    Image(systemName: "gift")
                    Text("나의 아토")
                }
        }.accentColor(Color(hex: "000000"))
}
}

struct BottomBar_Previews: PreviewProvider {
    static var previews: some View {
        BottomBar()
    }
}

