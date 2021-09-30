//
//  NewPostView.swift
//  ato_ios
//
//  Created by 김주희 on 2021/09/25.
//

import SwiftUI

struct NewPostView: View {
    
   @EnvironmentObject var viewModel: ViewModel
    @Binding var isPresented: Bool
    @Binding var title: String
    @Binding var post: String
    @State var isAlert = false
    var body: some View {
        NavigationView{
            ZStack{
                Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading){
                    Text("Create new Post")
                        .font(Font.system(size: 16, weight:.bold))
                    
                    TextField("Title", text: $title)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.bottom)
                    
                    TextField("Write something...", text: $post)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.bottom)
                    
                    Spacer()
                    
                }.padding()
                    .alert(isPresented: $isAlert, content: {
                        let title = Text("No data")
                        let message = Text("Please fill you title and post!")
                        return Alert(title: title, message: message)
                    })
            }
            .navigationTitle("New Post")
            .navigationBarItems(leading: leading, trailing: trailing)
        }
    }
    var leading: some View{
        Button(action:{
            isPresented.toggle()
        } , label: {
            
            Text("cancel")
        })
    }
    
    var trailing: some View{
        Button(action:{
            if title != "" && post != ""{
                let parameters: [String: Any] = ["title": title, "post": post]
                viewModel.createPosts(parameters: parameters)
                viewModel.fetchData()
                
                isPresented.toggle()
            } else {
                isAlert.toggle()
            }
//                    isPresented.toggle()
        } , label: {
            
            Text("save")
        })
    }
}




//struct NewPostView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewPostView()
//    }
//}
