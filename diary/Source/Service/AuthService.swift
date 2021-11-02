//
//  AuthService.swift
//  diary
//
//  Created by 김부성 on 2021/10/30.
//

import Foundation

import KeychainAccess
import RxSwift
import Moya

protocol AuthServiceType: AnyObject {
    var currentToken: Token? { get }
    
    func verifyEmail(_ email: String) -> Single<Void>
    func login(_ email: String, _ password: String) -> Single<Void>
}

final class AuthService: AuthServiceType {
    
    fileprivate let network: Network<AuthAPI>
    fileprivate let keychain = Keychain(service: "com.diary.someday.ios")
    private(set) var currentToken: Token?
    
    init(network: Network<AuthAPI>) {
        self.network = network
    }
    
    func verifyEmail(_ email: String) -> Single<Void> {
        return network.requestObject(.emailVerify(email), type: ServerResponse.self).map { _ in }
    }
    
    func login(_ email: String, _ password: String) -> Single<Void> {
        return network.requestObject(.login(email, password), type: ServerResponse.self).map { _ in }
    }
    
    fileprivate func saveToken(_ token: Token) throws {
        let jsonEncoder: JSONEncoder = JSONEncoder()
        
        let tokenData = try jsonEncoder.encode(token)
        let token = String(data: tokenData, encoding: .utf8)
        try self.keychain.set(token ?? "", key: "token")
    }
}
