//
//  AuthService.swift
//  diary
//
//  Created by 김부성 on 2021/10/30.
//

import Foundation


import RxSwift
import Moya

protocol AuthServiceType: AnyObject {
    func verifyEmail(_ email: String) -> Single<Void>
    func login(_ email: String, _ password: String) -> Single<Void>
}

final class AuthService: AuthServiceType {
    
    fileprivate let network: Network<AuthAPI>
    
    init(network: Network<AuthAPI>) {
        self.network = network
    }
    
    func verifyEmail(_ email: String) -> Single<Void> {
        return network.requestObject(.emailVerify(email), type: ServerResponse.self).map { _ in }
    }
    
    func login(_ email: String, _ password: String) -> Single<Void> {
        return network.requestObject(.login(email, password), type: ServerResponse.self).map { _ in }
    }
}
