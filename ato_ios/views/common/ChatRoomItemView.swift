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
    @EnvironmentObject var viewModel: ViewModel
    @EnvironmentObject var userViewModel: UserViewModel
//    init(userId: String, goodsId: String){
//        viewModel.fetchOneGoodsId(parameters: goodsId)
//    }
    var body: some View {
        VStack{
            HStack{
        Text("대화 상대 : ")
//                Text(userViewModel.oneUserItem?.username ?? "").onAppear(perform:{ userViewModel.fetchOneUser(parameters: userId)})
//            Text(title ?? "")
        }
        }
        .onAppear(perform: {

        })
    }

}

//struct ChatRoomItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatRoomItemView()
//    }
//}
