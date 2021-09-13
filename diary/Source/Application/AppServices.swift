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
    
    init() {
        let realm = try! Realm()
        
        self.realmService = RealmService(realm: realm)
    }
}
