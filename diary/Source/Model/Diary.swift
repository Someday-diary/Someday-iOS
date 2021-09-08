//
//  Diary.swift
//  diary
//
//  Created by 김부성 on 2021/09/05.
//

import Foundation
import RealmSwift

struct Diary: ModelType {
    // 작성 날짜
    var date: String
    
    // 작성 내용
    var data: String
    
    // 태그들
    var tags: String
}

class RealmDiary: Object, ModelType {
    @objc dynamic var date: String = String()
    @objc dynamic var data: String = String()
    @objc dynamic var tags: String = String()
    
    override class func primaryKey() -> String? {
        return "date"
    }
    
}

