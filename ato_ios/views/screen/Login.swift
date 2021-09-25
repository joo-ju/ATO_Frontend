//
//  Login.swift
//  ato_ios
//
//  Created by 김주희 on 2021/09/12.
//

import Foundation

import SwiftUI

struct Login : View {
    init() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearance.barTintColor = .white
        navBarAppearance.backgroundColor = .clear
        // 이하 두 줄이 구분 선 없애는 코드
        navBarAppearance.shadowImage = UIImage()
        navBarAppearance.setBackgroundImage(UIImage(), for: .default)
    }
    
    @State var username: String = ""
    @State var password: String = ""
    var body: some View {
        
        VStack{
            
            Text("Login Screen")
                .navigationBarTitle(Text("Dashboard"), displayMode: .inline)
            //            .background(NavigationConfigurator { nc in
            //                nc.navigationBar.barTintColor = .white
            //                nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
            //            })
            //            .navigationba
        
          
            //                    NavigationLink(destination: Register()){
                        VStack{
                            Rectangle().frame(height: 0)
                            Text("회원가입 하기")
                                .fontWeight(.bold)
                        }
                        .padding(.bottom, 20)
                        .padding(.top, 10)
                        .background(Color.black)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .padding(30)
            //                    }
            
        }
        
        
        
        

        
    }
}
