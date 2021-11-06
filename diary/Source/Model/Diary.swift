//
//  Diary.swift
//  diary
//
//  Created by 김부성 on 2021/09/05.
//

import Foundation
import RealmSwift

struct Diary: Equatable {
    // 작성 날짜
    var date: String
    
    // 작성 내용
    var data: String
    
    // 태그들
    var tags: String
    
    // ID
    var id: String
}

extension Diary {
    var toStorable: RealmDiary {
        let realmDiary = RealmDiary()
        realmDiary.date = self.date
        realmDiary.data = self.data
        realmDiary.tags = self.tags
        return realmDiary
    }
}
