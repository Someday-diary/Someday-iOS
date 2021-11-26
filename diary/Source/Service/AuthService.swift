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
    var currentPasscode: String? { get }
    
    func verifyEmail(_ email: String) -> Single<NetworkResult>
    func confirmEmail(_ email: String, _ code: String) -> Single<NetworkResult>
    func login(_ email: String, _ password: String) -> Single<NetworkResult>
    func register(_ email: String, _ password: String, _ agree: String) -> Single<NetworkResult>
    func logoutRequest() -> Single<NetworkResult>
    func logout()
    func setPasscode(passcode: String)
    func setBioPasscode()
    func getBioPasscode() -> String?
    func removePasscode()
    func removeBioPasscode()
}

final class AuthService: AuthServiceType {
    
    fileprivate let network: Network<AuthAPI>
    fileprivate let keychain = Keychain(service: "com.diary.someday.ios")
    private(set) var currentToken: Token?
    private(set) var currentPasscode: String?
    
    init(network: Network<AuthAPI>) {
        self.network = network
        self.currentToken = self.getToken()
        self.currentPasscode = self.getPasscode()
    }
    
    func verifyEmail(_ email: String) -> Single<NetworkResult> {
        return network.requestObject(.emailVerify(email), type: ServerResponse.self)
            .map { result in
                switch result{
                case .success(_):
                    return .success
                case let .error(error):
                    return .error(error)
                }
            }
    }
    
    func confirmEmail(_ email: String, _ code: String) -> Single<NetworkResult> {
        return network.requestObject(.emailConfirm(email, code), type: ServerResponse.self)
            .map { result in
                switch result {
                case .success(_):
                    return .success
                case let .error(error):
                    return .error(error)
                }
            }
    }

    func login(_ email: String, _ password: String) -> Single<NetworkResult> {
        return network.requestObject(.login(email, password), type: Token.self)
            .map { [weak self] result in
                switch result{
                case let .success(token):
                    try? self?.saveToken(token)
                    self?.currentToken = token
                    return .success
                case let .error(error):
                    return .error(error)
                }
            }
    }
    
    func register(_ email: String, _ password: String, _ agree: String) -> Single<NetworkResult> {
        return network.requestObject(.signUp(email, password, agree), type: ServerResponse.self)
            .map { result in
                switch result {
                case .success(_):
                    return .success
                case let .error(error):
                    return .error(error)
                }
            }
    }
    
    func logoutRequest() -> Single<NetworkResult> {
        return network.requestObject(.logOut(currentToken?.token ?? ""), type: ServerResponse.self)
            .map { result in
                switch result{
                case .success(_):
                    return .success
                case let .error(error):
                    return .error(error)
                }
            }
    }
    
    func setPasscode(passcode: String) {
        do {
            try self.keychain.set(passcode, key: "passcode")
            self.currentPasscode = passcode
            UserDefaults.standard.set(true, forKey: "passcode")
        } catch {
            UserDefaults.standard.set(false, forKey: "passcode")
        }
    }
    
    func setBioPasscode() {
        DispatchQueue.global().async {
            do {
                try self.keychain.accessibility(.whenUnlockedThisDeviceOnly, authenticationPolicy: [.biometryAny]).set(self.currentPasscode ?? "", key: "bioPasscode")
                UserDefaults.standard.set(true, forKey: "bioPasscode")
            } catch {
                UserDefaults.standard.set(false, forKey: "bioPasscode")
            }
        }
    }
    
    func removePasscode() {
        try? self.keychain.remove("passcode")
        try? self.keychain.remove("bioPasscode")
        UserDefaults.standard.set(false, forKey: "passcode")
        UserDefaults.standard.set(false, forKey: "bioPasscode")
    }
    
    func removeBioPasscode() {
        try? self.keychain.remove("bioPasscode")
        UserDefaults.standard.set(false, forKey: "bioPasscode")
    }
    
    func logout() {
        self.removeToken()
        self.removePasscode()
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
    
    fileprivate func getPasscode() -> String? {
        return try? keychain.getString("passcode")
    }
    
    func getBioPasscode() -> String? {
        var passcode: String?
        
        DispatchQueue.global().async {
            passcode = try? self.keychain.authenticationPrompt("Authenticate to login to server").get("bioPasscode")
        }
        
        return passcode
    }
    
    fileprivate func removeToken() {
        try? self.keychain.remove("token")
    }
}
