//
//  BaseAPI.swift
//  diary
//
//  Created by 김부성 on 2021/10/30.
//

import Moya
import Foundation

protocol BaseAPI: TargetType {}

extension BaseAPI {
    // aws
    var baseURL: URL { URL(string: "http://15.165.88.215:8080")! }
    // local
//    var baseURL: URL { URL(string: "http://10.80.161.192:8080")! }
    
    var headers: [String : String]? { nil }
    
    var method: Moya.Method { .get }
    
    var task: Task { .requestPlain }
    
    var sampleData: Data { Data() }
}
