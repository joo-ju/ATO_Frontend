


//import SwiftUI
//
//struct ContentView: View {
//    var body: some View {
//        HomeView()
//    }
//}

import SwiftUI
struct ContentView: View {
    enum Tabs{
        case tab1, tab2, myAto, chat, search, home
    }
    
    @ObservedObject var userInfo = UserInfo()
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var tabSelection = 0
    @State var tags = [""]
    @State var books = [Book]()
    var body: some View {
        NavigationView{
            
            MainView()
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)
        }
        .accentColor( .black)
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
