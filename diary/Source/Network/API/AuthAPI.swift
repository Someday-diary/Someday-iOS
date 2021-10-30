//
//  AuthAPI.swift
//  diary
//
//  Created by 김부성 on 2021/10/30.
//

import Foundation
import Moya

enum AuthAPI {
    // email
    case emailVerify(String)
    case emailConfirm(String, String)
    
    // user
    case signUp(String, String, String)
}

extension AuthAPI: BaseAPI {
    
    var path: String {
        switch self {
        case .emailVerify:
            return "/user/verify/"
        case .emailConfirm:
            return "/user/confirm/"
        case .signUp:
            return "/user/sign_up/"
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type" : "application/json"
        ]
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .post
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case let .emailVerify(email):
            return [
                "email" : email
            ]
        case let .emailConfirm(email, code):
            return [
                "email" : email,
                "code" : code
            ]
        case let .signUp(email, pwd, agree):
            return [
                "email" : email,
                "pwd" : pwd,
                "agree" : agree
            ]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var task: Task {
        if let parameters = parameters {
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        }
        return .requestPlain
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
