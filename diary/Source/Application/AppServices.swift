//
//  AppServices.swift
//  diary
//
//  Created by 김부성 on 2021/08/30.
//

import Foundation
import SnapKit
import PinLayout
import Then
import RxTheme
import CGFloatLiteral
import Rswift

struct AppServices {
    // not use
//    let realmService: RealmServiceType
    let userService: UserServiceType
    let authService: AuthServiceType
    let diaryService: DiaryServiceType
    
    init() {
//        print(Realm.Configuration.defaultConfiguration.fileURL!)
//        let realm = try! Realm()
//        self.realmService = RealmService(realm: realm)
        self.userService = UserService()
        
        let authNetwork = Network<AuthAPI>(plugins: [
            RequestLoggingPlugin()
        ])
        self.authService = AuthService(network: authNetwork)
        
        let diaryNetwork = Network<DiaryAPI>(
            plugins: [
                AuthPlugin(authService: authService),
                RequestLoggingPlugin()
            ]
        )
        self.diaryService = DiaryService(network: diaryNetwork)
    }
}
