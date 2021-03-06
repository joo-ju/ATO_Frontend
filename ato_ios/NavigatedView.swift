//
//  NavigationView.swift
//  ato_ios
//
//  Created by 김주희 on 2021/09/12.
//
import SwiftUI

struct NavigatedView: View {
    @State var tag:String? = nil
    var body: some View {
        Text("Hi! This is the NavigatedView")
            .navigationBarTitle("Navigated View", displayMode: .inline)
            
            NavigationLink(destination: Register(), tag: "register", selection: self.$tag ) {
                VStack{
                    Rectangle().frame(height: 0)
                    Text("로그인 하기")
                }
                .foregroundColor(.black)
                .padding(.bottom, 20)
                .padding(.top, 10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 3))
                .padding(30)
                
            }
    }
}
