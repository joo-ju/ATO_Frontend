//
//  DetailView.swift
//  ato_ios
//
//  Created by 김주희 on 2021/09/25.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode
    let item: PostModel
    @State var title=""
    @State var post=""
    var body: some View {
        
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
                    .onAppear(perform: {
                        self.title = item.title
                        self.post = item.post
                    })
            }
            .navigationTitle("Edit Post")
        //            .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems( trailing: trailing)
    

    }
    var trailing: some View{
        Button(action:{
            //update post
            if title != "" && post != "" {
                let parameters: [String: Any] = ["id": item._id, "title": title, "post": post ]
                viewModel.updatePosts(parameters: parameters)
                viewModel.fetchData()
                presentationMode.wrappedValue.dismiss()
            }
         
        } , label: {
          
        Text("save")
        })
    }
}

