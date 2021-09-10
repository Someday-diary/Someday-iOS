//
//  String.swift
//  diary
//
//  Created by 김부성 on 2021/09/08.
//

import Foundation

extension String {
    
    var realmDate: Date {
        let dateFormatter = DateFormatter().then {
            $0.dateFormat = "yyyy-MM-dd"
        }
        return dateFormatter.date(from: self)!
    }
}
