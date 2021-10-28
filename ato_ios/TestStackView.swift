//
//  TestStackView.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/27.
//

import SwiftUI

public struct FirstScreen: View {
  public init() {}
  public var body: some View {
//    NavigationView {
      List {
        row
        row
        row
      }
//    }
  }
  private var row: some View {
    NavigationLink(destination: SecondScreen()) {
      Text("Row")
    }
  }
}
struct SecondScreen: View {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var chatViewModel: ChatViewModel
  public var body: some View {
    VStack(spacing: 10) {
      NavigationLink(destination: thirdScreenA) {
        Text("Link to Third Screen A")
      }
      NavigationLink(destination: thirdScreenB()) {
        Text("Link to Third Screen B")
      }
      Button("Go back", action: { presentationMode.wrappedValue.dismiss() })
    }
    .onAppear(perform: {
//                    userViewModel.fetchOneUser(parameters: "616579dee6a40292c0bcab6a")
        chatViewModel.fetchGoodsRoom(goodsId: "6177a8ef40c91aa05fae3d71")
//                viewModel.fetchOneGoodsId(parameters: goodsItem._id)

    })
  }
  var thirdScreenA: some View {
    Text("thirdScreenA")
  }

}
struct thirdScreenB: View{
    @EnvironmentObject var chatViewModel: ChatViewModel
var body: some View {
    VStack{
        Text("thirdScreenB") }   .onAppear(perform: {
      //                    userViewModel.fetchOneUser(parameters: "616579dee6a40292c0bcab6a")
              chatViewModel.fetchGoodsRoom(goodsId: "6177a8ef40c91aa05fae3d71")
      //                viewModel.fetchOneGoodsId(parameters: goodsItem._id)

          })
}
}
//struct FirstScreen: View {
//    @State var secondScreenActive: Bool = false
//
//    public var body: some View {
//        NavigationView {
//            VStack {
//                Button("Go to screen 2") {
//                    secondScreenActive = true
//                }
//
//                NavigationLink(
//                    destination: SecondScreen(),
//                    isActive: $secondScreenActive,
//                    label: {
//                        EmptyView()
//                    }
//                )
//            }
//        }
//        .navigationViewStyle(StackNavigationViewStyle())
//    }
//}
//
//struct SecondScreen: View {
//    @State var thirdScreenActive: Bool = false
//
//    public var body: some View {
//        VStack {
//            Button("Go to screen 3") {
//                thirdScreenActive = true
//            }
//
//            NavigationLink(
//                destination: Text("Third Screen"),
//                isActive: $thirdScreenActive,
//                label: {}
//            )
//        }
//    }
//}



struct TestStackView2: View {
    
//    @State var keepView2: Bool = false
//
//      var body: some View{
//         if self.keepView2{
//             NavigationLink(destination: View2(keepViewOpen: self.$keepView2), isActive: self.$keepView2){
//                 Text("Navigate")
//             }
//         }
//      }
    @State var text = ""
    @EnvironmentObject var userViewModel: UserViewModel
    @ObservedObject var userInfo = UserInfo()
    var body: some View {
        VStack{
            NavigationLink(destination: Login()) {
            
                Text("go to Login")
                    .font(.title)
            }

            Text(userViewModel.oneUserItem?.username  ?? "")

        } .onAppear(perform: {
            userViewModel.fetchOneUser(parameters: self.userInfo.id)
        })
    }
}

struct TestStackView: View {
    
//    @State var keepView2: Bool = false
//
//      var body: some View{
//         if self.keepView2{
//             NavigationLink(destination: View2(keepViewOpen: self.$keepView2), isActive: self.$keepView2){
//                 Text("Navigate")
//             }
//         }
//      }
    @State var text = ""
    @EnvironmentObject var userViewModel: UserViewModel
    @ObservedObject var userInfo = UserInfo()
    var body: some View {
        VStack{
            NavigationLink(destination: TestStackView2(text:"2단계")) {
               
                Text(text)
                    .font(.title)
            }

            Text(userViewModel.oneUserItem?.username  ?? "")

        } .onAppear(perform: {
            userViewModel.fetchOneUser(parameters: self.userInfo.id)
        })
    }
}

//struct TestStackView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestStackView()
//    }
//}
//struct View2: View{
//
//    @Binding var keepViewOpen: Bool
//
//var body: some View{
//VStack{
//      Text("Hello World")
//}.onAppear{
//
//self.keepViewOpen = true
//       }
//   }
//}
