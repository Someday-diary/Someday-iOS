//
//  Themes.swift
//  diary
//
//  Created by 김부성 on 2021/08/30.
//

import RxTheme
import Rswift

protocol Theme {
    var mainColor: UIColor { get }
}

struct GreenTheme: Theme {
    let mainColor: UIColor = R.color.mainColor()!
}

enum ThemeType: ThemeProvider {
    case green
    var associatedObject: Theme {
        switch self {
        case .green:
            return GreenTheme()
        }
    }
}

let themeService = ThemeType.service(initial: .green)
