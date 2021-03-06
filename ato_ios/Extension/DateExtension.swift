//
//  DateExtension.swift
//  ato_ios
//
//  Created by 김주희 on 2021/10/30.
//

import Foundation
import Foundation
extension DateFormatter {
    convenience init (format: String) {
        self.init()
        dateFormat = format
        locale = Locale.current
    }
    
}
extension String {
    func toDate (format: String) -> Date? {
        return DateFormatter(format: format).date(from: self)
        
    }
    func toDateString (inputFormat: String, outputFormat:String) -> String? {
        if let date = toDate(format: inputFormat) {
            return DateFormatter(format: outputFormat).string(from: date)
            
        }
        return nil
        
    }
    
}
extension Date {
    func toString (format:String) -> String? {
        return DateFormatter(format: format).string(from: self)
        
    }
    
}



