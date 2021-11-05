//
//  RealmDiary.swift
//  diary
//
//  Created by 김부성 on 2021/10/06.
//

import Foundation
import RealmSwift

class RealmDiary: Object, ModelType {
    @objc dynamic var date: String = String()
    @objc dynamic var data: String = String()
    @objc dynamic var tags: String = String()
    @objc dynamic var id: String = String()
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}

extension RealmDiary {
    var toModel: Diary {
        return Diary(date: self.date, data: self.data, tags: self.tags, id: self.id)
    }
}
