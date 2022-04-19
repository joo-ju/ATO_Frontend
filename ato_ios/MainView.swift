//
//  MainView.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/07.
//


import SwiftUI
var tabs = ["house","message","gift"]
var tabs_name = ["홈",  "채팅", "나의아토"]
struct MainView: View {

    @State private var tabSelection = 0

    
    @ObservedObject var userInfo = UserInfo()
 
    @State var selectedTab = "house"
    @State var edge = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State var books = [Book]()
    
    init() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearance.barTintColor = .white
        navBarAppearance.backgroundColor = .clear
        // 이하 두 줄이 Navigation Bar 구분 선 없애는 코드
        navBarAppearance.shadowImage = UIImage()
        navBarAppearance.setBackgroundImage(UIImage(), for: .default)
    }
    var body: some View {
        
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            
            TabView(selection: $selectedTab) {
                
                MarketMain()
                    .tag("house")
                ChatListScreen()
                    .tag("message")
                
                if self.userInfo.username == "" { Login() .tag("gift")}
                else {MyAtoMainScreen() .tag("gift")}
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            Spacer()
            HStack(spacing: 0){

                ForEach(tabs,id: \.self){image in
                    TabButton(image: image, selectedTab: $selectedTab)
                    if image != tabs.last{

                        Spacer(minLength: 0)
                    }
                }
            }
            .padding(.horizontal,25)
            .padding(.vertical,5)
            .background(Color.white)
        }
    }
}


struct TabButton : View {
    
    var image : String
    @Binding var selectedTab : String
    
    var body: some View{
        
        Button(action: {selectedTab = image}) {
     
            Image(systemName: image)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(selectedTab == image ? Color(hex: "6279B8") : Color.black.opacity(0.4))
                .padding(10)
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
