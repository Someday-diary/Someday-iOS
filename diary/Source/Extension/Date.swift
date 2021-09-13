//
//  Date.swift
//  diary
//
//  Created by 김부성 on 2021/09/06.
//

import Foundation

extension Date {
    
    var titleString: String {
        let dateFormatter = DateFormatter().then {
            $0.dateFormat = "yyyy년"
        }
        return dateFormatter.string(from: self)
    }
    
    var toString: String {
        let dateFormatter = DateFormatter().then {
            $0.dateFormat = "yyyy년 MM월 dd일"
        }
        return dateFormatter.string(from: self)
    }
    
    var realmString: String {
        let dateFormatter = DateFormatter().then {
            $0.dateFormat = "yyyy-MM-dd"
        }
        return dateFormatter.string(from: self)
    }
    
    var today: Date {
        let dateFormatter = DateFormatter().then {
            $0.dateFormat = "yyyy-MM-dd"
        }
        
        return dateFormatter.date(from: (dateFormatter.string(from: self)))!
    }
    
    var changeTime: Date {
        return self.addingTimeInterval(TimeInterval(TimeZone.current.secondsFromGMT()))
    }
    
    var date: String {
        let dateFormatter = DateFormatter().then {
            $0.dateFormat = "dd"
        }
        return dateFormatter.string(from: self)
    }
}
