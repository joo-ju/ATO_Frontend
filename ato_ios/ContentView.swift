


//import SwiftUI
//
//struct ContentView: View {
//    var body: some View {
//        HomeView()
//    }
//}

import SwiftUI
//import Foundation

struct ContentView: View {
    enum Tabs{
        case tab1, tab2, myAto, chat, search, home
    }
    @State private var tabSelection = 0
    @State var tags = [""]
    @State var books = [Book]()
//    init() {
//        let navBarAppearance = UINavigationBar.appearance()
//        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
//        navBarAppearance.barTintColor = .white
//        navBarAppearance.backgroundColor = .clear
//        // 이하 두 줄이 Navigation Bar 구분 선 없애는 코드
//        navBarAppearance.shadowImage = UIImage()
//        navBarAppearance.setBackgroundImage(UIImage(), for: .default)
//    }
    var body: some View {
        NavigationView{
            
            MainView()
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)
        }
        .accentColor( .black)
        
//                NavigationView{
//        ZStack{
//        TabView(selection: $tabSelection){
//            //                NavigationView{ //if you write the NavigationView here, you cannot remove TabBar after navigation
//            VStack{
//                NavigationView{
//                    MarketMain()
//                }
//                .navigationBarHidden(true)
//                .navigationBarBackButtonHidden(true)
//            }
//            .tabItem {
//                Image(systemName: "house")
//                Text("홈")
//            }
//
//            .tag(Tabs.home)
//
//            VStack{
//
//                VStack{
//                    SearchScreen()
//
//                }.navigationBarHidden(true)
//
//            }
//            .tabItem {
//                Image(systemName: "magnifyingglass")
//                Text("검색")
//            }
//            .tag(Tabs.home)
//            VStack{
//
//
//                //                    NavigationLink(destination: NavigatedView()){
//                //                        VStack{
//                HomeView()
//                //                                .font(.largeTitle)
//
//
//                //                        }.navigationBarHidden(true)
//                //                    }
//            }
//            .tabItem {
//                Image(systemName: "message")
//                Text("채팅")
//
//            }
//            .tag(Tabs.chat)
//
//
//            VStack{
//                //                    Login()
//                NavigationView{
//                    MyAtoMainScreen()
//                }
//                .navigationBarHidden(true)
////                .navigationBarBackButtonHidden(true)
//            }
//            .tabItem {
//                Image(systemName: "gift")
//                Text("나의 아토")
//            }
//            .tag(Tabs.myAto)
//        }
        
        //            .navigationBarHidden(true)
        //            .navigationBarBackButtonHidden(true)
        //            .navigationBarHidden(true)
        //            .navigationBarBackButtonHidden()
        //
        //            .onAppear() {
        //                                    UITabBar.appearance().barTintColor = .black
        //                                       }
//        }
//
////                }
//                .navigationBarTitleDisplayMode(.inline)
//                .navigationBarHidden(true)
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
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
