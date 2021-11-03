//
//  Token.swift
//  diary
//
//  Created by 김부성 on 2021/11/02.
//

import Foundation

struct Token: ModelType {
    var code: Int
    var token: String
    var secretKey: String
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case token = "token"
        case secretKey = "secret_key"
    }
}
