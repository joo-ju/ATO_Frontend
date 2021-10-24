//
//  MainView.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/07.
//


import SwiftUI
//import Foundation
var tabs = ["house","magnifyingglass","message","gift"]
var tabs_name = ["홈", "검색", "채팅", "나의아토"]
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
//            Color(hex: "C3D3FE").edgesIgnoringSafeArea(.top)
//            Color.clear.edgesIgnoringSafeArea(.top)
            // Using Tab View For Swipe Gestures...
            // if you dont need swipe gesture tab change means just use switch case....to switch views...
            
            TabView(selection: $selectedTab) {
                
                MarketMain()
                    .tag("house")
                
//                SearchScreen()
//                TestChatView()
                    .tag("magnifyingglass")
                    
                HomeView()
                    .tag("message")
                
                if self.userInfo.username == "" { Login() .tag("gift")}
                else {MyAtoMainScreen() .tag("gift")}
//                    .tag("gift")
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
//            .ignoresSafeArea(.all, edges: .bottom)
            // for bottom overflow...
            Spacer()
            HStack(spacing: 0){

                ForEach(tabs,id: \.self){image in
                    TabButton(image: image, selectedTab: $selectedTab)

                    // equal spacing...

                    if image != tabs.last{

                        Spacer(minLength: 0)
                    }
                }
            }
            .padding(.horizontal,25)
            .padding(.vertical,5)
            .background(Color.white)
//            .clipShape(Capsule())
//            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 5, y: 5)
//            .shadow(color: Color.black.opacity(0.15), radius: 5, x: -5, y: -5)
//            .padding(.horizontal)
            // for smaller iphones....
            // elevations...
//            .padding(.bottom,edge!.bottom == 0 ? 20 : 0)
            
            // ignoring tabview elevation....
        }
//        .ignoresSafeArea(.keyboard, edges: .bottom)
//        .background(Color.black.opacity(0.05).ignoresSafeArea(.all, edges: .all))
        
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
//                .renderingMode(.template)
                .foregroundColor(selectedTab == image ? Color(hex: "6279B8") : Color.black.opacity(0.4))
                .padding(10)
//            Text("")
            
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

//
//import SwiftUI
//
//struct ChipsDataModel: Identifiable {
//    let id = UUID()
//    @State var isSelected: Bool
//    let systemImage: String
//    let titleKey: LocalizedStringKey
//}
//
//class ChipsViewModel: ObservableObject {
//    @Published var dataObject: [ChipsDataModel] = [ChipsDataModel.init(isSelected: false, systemImage: "pencil.circle", titleKey: "Pencil Circle")]
//
//    func addChip() {
//        dataObject.append(ChipsDataModel.init(isSelected: false, systemImage: "pencil.circle", titleKey: "Pencil"))
//    }
//
//    func removeLast() {
//        guard dataObject.count != 0 else {
//            return
//        }
//        dataObject.removeLast()
//    }
//}
//
//struct ContentView: View {
//    @StateObject var viewModel = ChipsViewModel()
//    var body: some View {
//        VStack {
//            ScrollView {
//                ChipsContent(viewModel: viewModel)
//            }
//            Spacer()
//            HStack {
//                Spacer()
//                Button("Remove Chips") {
//                    withAnimation {
//                        viewModel.removeLast()
//                    }
//                }.padding(.all, 40).accentColor(.red)
//                Spacer()
//                Button("Add Chips") {
//                    withAnimation {
//                        viewModel.addChip()
//                    }
//                }.padding(.all, 40)
//                Spacer()
//            }
//
//
//        }
//    }
//}
//
//struct ChipsContent: View {
//    @ObservedObject var viewModel = ChipsViewModel()
//    var body: some View {
//        var width = CGFloat.zero
//        var height = CGFloat.zero
//        return GeometryReader { geo in
//                ZStack(alignment: .topLeading, content: {
//                ForEach(viewModel.dataObject) { chipsData in
//                    Chips(systemImage: chipsData.systemImage,
//                          titleKey: chipsData.titleKey,
//                          isSelected: chipsData.isSelected)
//                        .padding(.all, 5)
//                        .alignmentGuide(.leading) { dimension in
//                            if (abs(width - dimension.width) > geo.size.width) {
//                                width = 0
//                                height -= dimension.height
//                            }
//
//                            let result = width
//                            if chipsData.id == viewModel.dataObject.last!.id {
//                                width = 0
//                            } else {
//                                width -= dimension.width
//                            }
//                            return result
//                          }
//                        .alignmentGuide(.top) { dimension in
//                            let result = height
//                            if chipsData.id == viewModel.dataObject.last!.id {
//                                height = 0
//                            }
//                            return result
//                        }
//                }
//            })
//        }.padding(.all, 10)
//    }
//}
//
//
//struct Chips: View {
//    let systemImage: String
//    let titleKey: LocalizedStringKey
//    @State var isSelected: Bool
//    var body: some View {
//        HStack {
//            Image.init(systemName: systemImage).font(.title3)
//            Text(titleKey).font(.title3).lineLimit(1)
//        }.padding(.all, 10)
//        .foregroundColor(isSelected ? .white : .blue)
//        .background(isSelected ? Color.blue : Color.white)
//        .cornerRadius(40)
//        .overlay(
//                RoundedRectangle(cornerRadius: 40)
//                    .stroke(Color.blue, lineWidth: 1.5)
//
//        ).onTapGesture {
//            isSelected.toggle()
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
