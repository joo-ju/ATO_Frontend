//
//  stateBottomBar.swift
//  ato_ios
//
//  Created by 김주희 on 2021/09/12.
//

import Foundation

class stateBBar: ObservableObject {
    // 1이면 하단바 있는 거고 0 이면 없는거
    @Published var state: Int = 1
}
