//
//  HomeView.swift
//  ato_ios
//
//  Created by 김주희 on 2021/09/25.
//

import SwiftUI

struct HomeView: View {
    
    
    
    
    
    @EnvironmentObject var viewModel: ViewModel
    @State var isPresentedNewPost = false
    @State var title = ""
    @State var post = ""
    var body: some View {

        NavigationView{
            List{
                ForEach(viewModel.items, id: \._id){ item in
                    NavigationLink(destination: DetailView(item: item), label: {
                        VStack(alignment: .leading){
                            Text(item.title)
                            Text(item.post)
                                .font(.caption).foregroundColor(.gray)
                        }
                    })
                }
            }
            .listStyle(InsetListStyle())
            .navigationBarTitle("Posts")
            .navigationBarItems(trailing: plusButton)
        }.sheet(isPresented: $isPresentedNewPost, content: {
            NewPostView(isPresented: $isPresentedNewPost, title: $title, post: $post)
        })
            .onAppear(perform: {
                viewModel.fetchData()
            })
    }

    var plusButton: some View {
        Button(action: {
            isPresentedNewPost.toggle()
        }, label: {
            Image(systemName: "plus")
        })
    }
}
