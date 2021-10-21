//
//  NewMarcketReviewScreen.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/10.
//

import SwiftUI

struct NewGoodsReviewScreen: View {
    
    @EnvironmentObject var reviewViewModel: ReviewViewModel
    @EnvironmentObject var viewModel: ViewModel
    @Binding var isPresented: Bool
    @Binding var writer: String
    @Binding var content: String
    @State var goodsId: String
    @Binding var score: Int
    @Binding var tags: Array<String>
    
    @State var isAlert = false          // 모두 입력하지 않을시 띄움
    
    @State var buyerId = "joo"
    @State var show = false
    @State var ratings = 0
    
    // score의 INT형을 입력받기 위한 formatter
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView{
            
//            VStack{
//
////                VStack{
////
////                    Button(action: {
////
////                        self.ratings = 0
////                        self.show.toggle()
////
////                    }) {
////
////                        Text("Review").fontWeight(.bold).foregroundColor(.green)
////                    }
////
////                    if self.ratings != 0{
////
////                        Text("Ratings = \(self.ratings)").fontWeight(.bold).foregroundColor(.green).padding(.top, 25)
////                    }
////                }
//
////                if self.show{
//
////                    GeometryReader{_ in
//
//                        VStack{
//
//
//                        }
//
////                    }.background(Color.black.opacity(0.2).edgesIgnoringSafeArea(.all))
////                }
//
//            }.animation(.default)
            
            
            
            VStack(spacing: 0){
                Rectangle().frame(height:0)
                ScrollView{
                    FeedBack(ratings: self.$score).padding()
                    VStack{
                        ScrollView{
                            Divider()
                                .padding([.leading, .trailing], 20)
                            TextField("리뷰를 작성해주세요.", text: $content)
                                .frame(height: 200, alignment: .topLeading)
                                .padding(10)
                                .padding([.leading, .trailing], 20)
                        } // end ScrollView
                        
                        Divider()
                            .padding([.leading, .trailing], 20)
//                        TextField("점수", value: $ratings), formatter: formatter
                                                TextField("점수", value: $score, formatter: formatter)
                            .padding(10)
                            .padding([.leading, .trailing], 20)
                        Divider()
                            .padding([.leading, .trailing], 20)
              
                        
                        
                    }// end VStack
                    
                    MarcketWriteChips(tags: $tags)
                } // end ScrollView
                Spacer()
            }// end Vstack
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            
        } // end NavigationView
        
        .navigationBarBackButtonHidden(true)
//        .navigationTitle("구매후기")
        .navigationBarItems(leading: leading, trailing: trailing)
    }
    
    var leading: some View{
        Button(action:{
//            isPresented.toggle()
            presentationMode.wrappedValue.dismiss()
        } , label: {
            Text("닫기")
//                .padding([.leading, .trailing])
                .padding([.top, .bottom], 15)
                .foregroundColor(Color(hex: "838383"))
        })
    }
    var trailing: some View{
        Button(action:{
            if content != ""{
                tags.removeFirst()
                let parameters: [String: Any] = ["content": content, "tags": tags,"score": score, "goodsId": goodsId]
                print("tags : ", tags)
                print("\tscore : ", score)
                reviewViewModel.createReveiwGoods(parameters: parameters)
                presentationMode.wrappedValue.dismiss()
                
                viewModel.fetchGoodsBuyBuyerId(parameters: buyerId)
 
//                reviewViewModel.fetchAllGoods()

            } else {
                isAlert.toggle()
            }
            
        } , label: {
            
            Text("완료")
                .fontWeight(.bold)
//                .padding([.leading, .trailing])
                .padding([.top, .bottom], 15)
                .foregroundColor(Color(hex: "6279B8"))
        })
    }
}

//struct NewGoodsReviewScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        NewGoodsReviewScreen()
//    }
//}
