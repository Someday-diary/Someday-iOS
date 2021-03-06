//
//  String.swift
//  diary
//
//  Created by 김부성 on 2021/09/08.
//

import Foundation

extension String {
  
  var localized: String {
    return NSLocalizedString(self, tableName: "Localizable", value: self, comment: "")
  }
    
    var monthToDate: Date {
        let dateFormatter = DateFormatter().then {
            $0.dateFormat = "yyyy-MM"
        }
        return dateFormatter.date(from: self)!
    }
    
    var days: String {
        return String(self.dropFirst(8))
    }
}
