//
//  Token.swift
//  diary
//
//  Created by 김부성 on 2021/11/02.
//

import Foundation

struct Token: ModelType {
    var accessToken: String
    var secretKey: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case secretKey = "secret_key"
    }
}
