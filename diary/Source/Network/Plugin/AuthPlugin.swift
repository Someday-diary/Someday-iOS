//
//  AuthPlugin.swift
//  diary
//
//  Created by 김부성 on 2021/11/02.
//

import Moya

struct AuthPlugin: PluginType {
    fileprivate let authService: AuthServiceType
    
    init(authService: AuthServiceType) {
        self.authService = authService
    }
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        if let token = self.authService.currentToken?.token {
            request.addValue(token, forHTTPHeaderField: "access_token")
        }
        return request
    }
}
