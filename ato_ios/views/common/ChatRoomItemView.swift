//
//  ChatRoomItemView.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/26.
//

import SwiftUI

struct ChatRoomItemView: View {
    @State var userId = ""
    @State var goodsId = ""
    @State var title:String?
    let roomItem: RoomModel
    @EnvironmentObject var viewModel: ViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    @ObservedObject var userInfo = UserInfo()
    //    init(userId: String, goodsId: String){
    //        viewModel.fetchOneGoodsId(parameters: goodsId)
    //    }
    var body: some View {
        VStack{
            HStack{
//                Text("대화 상대 : ")
                HStack{
                    Text("굿즈 title : ")
                    Text(viewModel.oneGoodsItem?.title ?? "")
                }
                //                Text(userViewModel.oneUserItem?.username ?? "").onAppear(perform:{ userViewModel.fetchOneUser(parameters: userId)})
                //            Text(title ?? "")
            }
        }
        .onAppear(perform: {
            if roomItem.sellerId == self.userInfo.id {
                userViewModel.fetchOneUser(parameters: roomItem.customerId)
                viewModel.fetchOneGoodsId(parameters: roomItem.goodsId)
            } else {
                userViewModel.fetchOneUser(parameters: roomItem.sellerId)
                viewModel.fetchOneGoodsId(parameters: roomItem.goodsId)
            }
        })
    }
    
}

//struct ChatRoomItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatRoomItemView()
//    }
//}
