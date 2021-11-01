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
    
    @State var containerHeight: CGFloat = 400
    @ObservedObject var userInfo = UserInfo()
    @Binding var isPresented: Bool
//    @Binding var writer: String
//    @Binding var content: String
    @State var goodsId: String
//    @Binding var score: Int
    
    @State var isAlert = false          // 모두 입력하지 않을시 띄움
    
    @State var buyerId = "joo"
    @State var show = false
    @State var ratings = 0
    @State var score = 0
    @State var content = ""
    
    
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
                HStack{
                    leading
                    Spacer()
                    trailing
                }
                Rectangle().frame(height:0)
                ScrollView{
                    FeedBack(ratings: self.$score).padding()
                    VStack{
                        ScrollView{
                            Divider()
                                .padding([.leading, .trailing], 20)
                            AutoSizingTF(hint: "판매 글의 내용을 작성해주세요.", text: $content,containerHeight: $containerHeight, onEnd: {
                                
                                // Do when keyboard closed...
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            })
                                .padding(.horizontal)
//                                .lineSpacing(50)
                                // Your Max Height Here....
//                                .frame(height: containerHeight <= 400 ? containerHeight : 400)
                                .frame(height: 400)
                                .background(Color.white)
                                .cornerRadius(10)
                                .padding()
//                            TextField("리뷰를 작성해주세요.", text: $content)
//                                .frame(height: 200, alignment: .topLeading)
//                                .padding(10)
//                                .padding([.leading, .trailing], 20)
                        } // end ScrollView
                        
                        Divider()
                            .padding([.leading, .trailing], 20)
//                        TextField("점수", value: $ratings), formatter: formatter
//                                                TextField("점수", value: $score, formatter: formatter)
//                            .padding(10)
//                            .padding([.leading, .trailing], 20)
              
                        
                        
                    }// end VStack
                    
//                    MarcketWriteChips(tags: $tags)
                } // end ScrollView
                Spacer()
            }// end Vstack
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            
        } // end NavigationView
        
        .navigationBarBackButtonHidden(true)
//        .navigationTitle("구매후기")
//        .navigationBarItems(leading: leading, trailing: trailing)
    }
    
    var leading: some View{
        Button(action:{
            content = ""
            score = 0
            
            isPresented.toggle()
//            presentationMode.wrappedValue.dismiss()
        } , label: {
            Text("닫기")
//                .padding([.leading, .trailing])
//                .padding([.top, .bottom], 15)
                .padding()
                .foregroundColor(Color(hex: "838383"))
                .onAppear(perform: {
                    print(goodsId)
                })
        })
    }
    var trailing: some View{
        Button(action:{
            if content != ""{
           
                let parameters: [String: Any] = ["writer": self.userInfo.id,"content": content, "score": score, "goodsId": goodsId]
             
                print("\tscore : ", score)
                reviewViewModel.createReveiwGoods(parameters: parameters)
                
                isPresented.toggle()
//                presentationMode.wrappedValue.dismiss()
                
//                viewModel.fetchGoodsBuyBuyerId(parameters: buyerId)
 
//                reviewViewModel.fetchAllGoods()

            } else {
                isAlert.toggle()
            }
            
        } , label: {
            
            Text("완료")
                .fontWeight(.bold)
//                .padding([.leading, .trailing])
//                .padding([.top, .bottom], 15)
                .padding()
                .foregroundColor(Color(hex: "6279B8"))
        })
    }
}

//struct NewGoodsReviewScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        NewGoodsReviewScreen()
//    }
//}
