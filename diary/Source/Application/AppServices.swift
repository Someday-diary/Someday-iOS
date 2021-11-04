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
    let diaryService: DiaryServiceType
    
    init() {
        self.userService = UserService()
        
        let authNetwork = Network<AuthAPI>()
        self.authService = AuthService(network: authNetwork)
        
        let diaryNetwork = Network<DiaryAPI>(
            plugins: [
                AuthPlugin(authService: authService),
                RequestLoggingPlugin()
            ]
        )
        self.diaryService = DiaryService(network: diaryNetwork)
        
        let realm = try! Realm()
        self.realmService = RealmService(realm: realm)
    }
}
