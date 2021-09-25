//
//  EventSearchTab.swift
//  ato_ios
//
//  Created by 김주희 on 2021/09/17.
//

import Foundation
import SwiftUI

struct EventSearchTab: View {
    var body: some View {
        
        ZStack{
                  Rectangle()
                      .foregroundColor(.orange)
                  Text("event search")
              }
    }
}

struct EventSearchTab_Previews: PreviewProvider {
    static var previews: some View {
        EventSearchTab()
    }
}



