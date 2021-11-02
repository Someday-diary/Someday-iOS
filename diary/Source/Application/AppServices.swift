//
//  AppServices.swift
//  diary
//
//  Created by 김부성 on 2021/08/30.
//

import Foundation
import SnapKit
import Then
import RxTheme
import CGFloatLiteral
import RealmSwift
import Rswift

struct AppServices {
    let realmService: RealmServiceType
    let userService: UserServiceType
    let authService: AuthServiceType
    
    init() {
        let realm = try! Realm()
        
        let authNetwork = Network<AuthAPI>()
        self.realmService = RealmService(realm: realm)
        self.userService = UserService()
        self.authService = AuthService(network: authNetwork)
    }
}
