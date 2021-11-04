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
    var postID: String?
    
    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case code
    }
}

// MARK: - ListResponse
struct ListResponse: ModelType {
    var code: Int
    var posts: [Post]?
}

struct Post: ModelType {
    var date: Date
    var postID: String
    
    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case date
    }
}

// MARK: - DiaryResponse
struct DiaryResponse: ModelType {
    let postID, contents, email, date: String?
    let tag: [Tag]?
    let code: Int

    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case contents, email, date, tag, code
    }
}

// MARK: - Tag
struct Tag: Codable {
    let tagName: String

    enum CodingKeys: String, CodingKey {
        case tagName = "tag_name"
    }
}
