//
//  DiaryResponse.swift
//  diary
//
//  Created by 김부성 on 2021/11/04.
//

import Foundation

extension Post {
    var toDiary: Diary {
        let tag = self.tags.map { "#" + $0.tagName + " "}.reduce("", +).dropLast()
        return Diary(date: self.date, data: self.contents, tags: String(tag), id: self.postID)
    }
}
