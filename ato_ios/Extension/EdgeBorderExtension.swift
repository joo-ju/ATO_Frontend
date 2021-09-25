//
//  EdgeExtension.swift
//  ato_ios
//
//  Created by 김주희 on 2021/09/15.
//




import Foundation
import SwiftUI

struct EdgeBorder: Shape {

    var width: CGFloat
    var edges: [Edge]

    func path(in rect: CGRect) -> Path {
        var path = Path()
        for edge in edges {
            var x: CGFloat {
                switch edge {
                case .top, .bottom, .leading: return rect.minX
                case .trailing: return rect.maxX - width
                }
            }

            var y: CGFloat {
                switch edge {
                case .top, .leading, .trailing: return rect.minY
                case .bottom: return rect.maxY - width
                }
            }

            var w: CGFloat {
                switch edge {
                case .top, .bottom: return rect.width
                case .leading, .trailing: return self.width
                }
            }

            var h: CGFloat {
                switch edge {
                case .top, .bottom: return self.width
                case .leading, .trailing: return rect.height
                }
            }
            path.addPath(Path(CGRect(x: x, y: y, width: w, height: h)))
        }
        return path
    }
}

extension View {
    func border(width: CGFloat, edges: [Edge], color: SwiftUI.Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}


//
//import Foundation
//import SwiftUI
//
//struct EdgeBorder: Shape {
//    var width: CGFloat
//    var edge: Edge
//    func path(in rect: CGRect) -> Path {
//        var x: CGFloat {
//            switch edge {
//            case .top, .bottom, .leading: return rect.minX
//            case .trailing: return rect.maxX - width
//            }
//        }
//        var y: CGFloat {
//            switch edge {
//            case .top, .leading, .trailing: return rect.minY
//            case .bottom: return rect.maxY - width
//            }
//        }
//        var w: CGFloat {
//            switch edge {
//            case .top, .bottom: return rect.width
//            case .leading, .trailing: return self.width
//            }
//        }
//        var h: CGFloat {
//            switch edge {
//            case .top, .bottom: return self.width
//            case .leading, .trailing: return rect.height
//            }
//        }
//        return Path( CGRect(x: x, y: y, width: w, height: h) )
//    }
//}
//
//extension View {
//    func border(width: CGFloat, edge: Edge, color: Color) -> some View {
//        ZStack {
//            self
//            EdgeBorder(width: width, edge: edge).foregroundColor(color)
//        }
//    }
//}
//extension View {
//    func _border(width: CGFloat, edge: Edge, color: Color) -> some View {
//        VStack {
//            self
//            EdgeBorder(width: width, edge: edge).foregroundColor(color)
//        }
//    }
//}
