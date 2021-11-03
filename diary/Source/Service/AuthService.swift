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
    func logout()
}

final class AuthService: AuthServiceType {
    
    fileprivate let network: Network<AuthAPI>
    fileprivate let keychain = Keychain(service: "com.diary.someday.ios")
    private(set) var currentToken: Token?
    
    init(network: Network<AuthAPI>) {
        self.network = network
        self.currentToken = self.getToken()
    }
    
    func verifyEmail(_ email: String) -> Single<Void> {
        return network.requestObject(.emailVerify(email), type: ServerResponse.self).map { _ in }
    }
    
    func login(_ email: String, _ password: String) -> Single<Void> {
        return network.requestObject(.login(email, password), type: Token.self)
            .do(onSuccess: { [weak self] response in
                try? self?.saveToken(response)
                self?.currentToken = response
            }).map { _ in }
    }
    
    func logout() {
        self.removeToken()
        self.currentToken = nil
    }
    
    fileprivate func saveToken(_ token: Token) throws {
        let jsonEncoder: JSONEncoder = JSONEncoder()
        
        let tokenData = try jsonEncoder.encode(token)
        let token = String(data: tokenData, encoding: .utf8)
        try self.keychain.set(token ?? "", key: "token")
    }
    
    fileprivate func getToken() -> Token? {
        let jsonDecoder: JSONDecoder = JSONDecoder()
        
        guard let tokenData = self.keychain["token"]?.data(using: .utf8),
              let token = try? jsonDecoder.decode(Token.self, from: tokenData)
        else { return nil }
        
        return token
    }
    
    fileprivate func removeToken() {
        try? self.keychain.remove("token")
    }
}
