//
//  ServerResponse.swift
//  diary
//
//  Created by 김부성 on 2021/10/27.
//

import Foundation

struct ServerResponse: ModelType {
    var code: Int
}

struct CreateResponse: ModelType {
    var code: Int
    var postID: String
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case postID = "post_id"
    }
}
