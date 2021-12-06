//
//  DiaryList.swift
//  diary
//
//  Created by 김부성 on 2021/11/03.
//

import Foundation

struct DiaryList: ModelType {
    var date: String
    var postID: String
    
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case postID = "post_id"
    }
}
