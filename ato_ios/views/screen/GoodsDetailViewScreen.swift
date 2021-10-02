//
//  GoodsViewScreen.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/02.
//  각각의 상품 판매 글을 상세히 볼 수 있는 Screen

import SwiftUI

struct GoodsDetailViewScreen: View {
//    @State var tags = [String]()
//
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode
    let goodsItem: GoodsModel
    @State var title = ""
    @State var content = ""
    @State var price = 0
    @State var tags = [""]
    
    var body: some View {
        //        ZStack{
  
//            ZStack(alignment: .topLeading) {
      
        VStack(alignment: .leading, spacing: 10) {
            Button(action: {
                           presentationMode.wrappedValue.dismiss()
                       }, label: {
                           Image(systemName: "xmark")
                               .imageScale(.large)
                               .padding()
                       })
                       .accentColor(.black)
            ScrollView{
                VStack(alignment: .leading, spacing: 10) {
                    Rectangle().frame(height:0)
                    Text(title)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .padding([.top, .bottom], 10)
                    
                    Divider()
                    
//                    Text("It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various verIt is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).sions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).")
                    Text(content)
                        .padding([.top, .bottom], 10)
                    
                        .lineSpacing(5)
                    
                    Divider()
                    Spacer()
                } // end of VStack
                
            } // end of ScrollView
            
            .padding([.leading, .trailing], 20)
            
            HStack{
                Image(systemName: "heart")
                    .resizable()
                    .frame(width:20, height: 15)
                    .foregroundColor(Color(hex: "c4c4c4"))
                Divider()
                    .padding(.leading, 5)
                    .padding(.trailing, 5)
//                Text("20,000원")
                Text("\(price)")
                    .fontWeight(.bold)
                Spacer()
                Button(action:{ }, label: {
                    VStack{
                        //                            Rectangle().frame(height: 0)
                        Text("판매자와 채팅하기")
                            .fontWeight(.bold)
                    }
                    .frame(width: 140)
                    .padding(10)
                    .background(Color(hex: "A9BCE8"))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                })
            } // end of HStack
            .frame(height: 50, alignment: .center)
            .padding([.leading, .trailing], 15)
            .padding(.leading, 5)
            //                .background(Color.green)
            
        } // end of VStack
//        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
        .onAppear(perform: {
            self.title = goodsItem.title
            self.content = goodsItem.content
            self.price = goodsItem.price
            self.tags = goodsItem.tags
//            self.content = item.post
        })

        
//            } // end of ZStack
        
    }
    
}
//
//struct GoodsViewScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        GoodsDetailViewScreen()
//    }
//}
