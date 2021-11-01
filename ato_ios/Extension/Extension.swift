//
//  Extension.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/08.
//

import SwiftUI
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    static func endEditing(){
        UIApplication.shared.windows.forEach{$0.endEditing(false)}
    }
//    func listSeparatorStyle(style: UITableViewCell.SeparatorStyle) -> some View {
////         ModifiedContent(content: self, modifier: ListSeparatorStyle(style: style))
//     }
}


struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

//struct ListSeparatorStyle: ViewModifier {
//
//    let style: UITableViewCell.SeparatorStyle
//
//    func body(content: Content) -> some View {
//        content
//            .onAppear() {
//                UITableView.appearance().separatorStyle = self.style
//            }
//    }
//}
extension String {
    func toDate() -> Date? { //"yyyy-MM-dd HH:mm:ss"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: self) {
            return date
            
        } else {
            return nil
            
        }
    }
    
}
extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.string(from: self)
        
    }
    
}

extension String {
    func load() -> UIImage{
        do {
            guard let url = URL(string: self) else {
                return UIImage()
            }
            
            let data: Data = try Data(contentsOf: url)
            
            // create UIImage object form Data
            return UIImage(data: data) ?? UIImage()
            
        } catch {
            
        }
        return UIImage()
    }
}
