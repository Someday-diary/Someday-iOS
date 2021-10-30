//
//  BaseAPI.swift
//  diary
//
//  Created by 김부성 on 2021/10/30.
//

import Moya

protocol BaseAPI: TargetType {}

extension BaseAPI {
    var baseURL: URL { URL(string: "")! }
    
    var headers: [String : String]? { nil }
    
    var method: Method { .get }
    
    var task: Task { .requestPlain }
    
    var sampleData: Data { Data() }
}
