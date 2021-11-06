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
      List {
        row
        row
        row
      }
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
        chatViewModel.fetchGoodsRoom(goodsId: "6177a8ef40c91aa05fae3d71")

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
              chatViewModel.fetchGoodsRoom(goodsId: "6177a8ef40c91aa05fae3d71")
          })
}
}



struct TestStackView2: View {
    
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
