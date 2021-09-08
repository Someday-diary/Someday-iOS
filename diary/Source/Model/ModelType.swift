//
//  ModelType.swift
//  diary
//
//  Created by 김부성 on 2021/09/05.
//

import Then

protocol ModelType: Codable ,Then {
    static var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy { get }
}

extension ModelType {
    static var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy {
        return .iso8601
    }
}

