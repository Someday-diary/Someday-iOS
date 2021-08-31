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
import Rswift

struct AppServices {
    let themeService: ThemeServiceType
    
    init() {
        self.themeService = ThemeService()
    }
}
