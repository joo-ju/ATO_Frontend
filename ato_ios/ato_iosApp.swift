//
//  ato_iosApp.swift
//  ato_ios
//
//  Created by 김주희 on 2021/09/08.
//

import SwiftUI

@main
struct ato_iosApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ViewModel())
                .environmentObject(ReviewViewModel())
                .environmentObject(UserViewModel())
        }
    }
}
