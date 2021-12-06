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
    var posts: [Posts]?
}

struct Posts: Codable {
    let postID: String
    let date: Date
    
    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case date
    }
}

// MARK: - DiaryResponse
struct DiaryResponse: ModelType, Equatable {
    let post: Post?
    let code: Int
}

struct DiaryListResponse: ModelType, Equatable {
    let posts: [Post]?
    let code: Int
}

struct Post: Codable, Equatable {
    let postID, contents, date: String
    let tags: [Tag]
    
    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case contents, date, tags
    }
}

// MARK: - Tag
struct Tag: Codable, Equatable {
    let tagName: String

    enum CodingKeys: String, CodingKey {
        case tagName = "tag_name"
    }
}
