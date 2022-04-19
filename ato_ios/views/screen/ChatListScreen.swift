//
//  ChatListScreen.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/26.
//

import SwiftUI
class RoomService: ObservableObject {

    
    @ObservedObject var userInfo = UserInfo()
    @EnvironmentObject var viewModel: ViewModel
    @EnvironmentObject var chatViewModel: ChatViewModel
    
    @Published var messages = [String]()
    @Published var writers = [String]()
    @Published var contents = [Content]()
}
struct ChatListScreen: View {
    
    @ObservedObject var userInfo = UserInfo()
    @EnvironmentObject var viewModel: ViewModel
    @EnvironmentObject var chatViewModel: ChatViewModel
    @EnvironmentObject var userViewModel: UserViewModel
   
    @State var title = ""
    @State var sample = RoomModel(_id: "", sellerId: "", customerId: "", goodsId: "", isDeleted: false)
    @State var lastMsgIdx = 0
    var body: some View {
        VStack(spacing: 10) {
            if chatViewModel.roomAllItems.count > 0 {
            List{
                KRefreshScrollView(progressTint: .purple, arrowTint: .purple) {
                  
                    ForEach(chatViewModel.roomAllItems, id: \._id){ roomItem in
                        ChatRoomItemView(roomItem: roomItem)
                        

                            }
                    } onUpdate: {
                    chatViewModel.fetchAllRoom()
                }
                    .onAppear(perform: {
                    chatViewModel.fetchAllRoom()
                    
                })
                
            }
            .listStyle(InsetListStyle())
    

        
    }
    else {
        VStack{
        Text("생성된 대화가 없습니다.")
                .foregroundColor(Color(hex:"c4c4c4"))
            Spacer()
        }
        
    }
        }
        .onAppear(perform: {
            chatViewModel.fetchAllRoom()
            
        })
    }
}
