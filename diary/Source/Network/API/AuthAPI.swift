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
    case login(String, String)
    case logOut(String)
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
        case .login:
            return "/user/login/"
        case .logOut:
            return "/user/logout/"
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case let .logOut(token):
            return [
                "access_token" : token
            ]
        default :
            return [
                "Content-Type" : "application/json"
            ]
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .logOut:
            return .delete
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
        case let .login(email, pwd):
            return [
                "email" : email,
                "pwd" : pwd
            ]
        default:
            return nil
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
        return .none
    }
}
