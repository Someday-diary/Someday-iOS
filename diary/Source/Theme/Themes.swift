//
//  Themes.swift
//  diary
//
//  Created by 김부성 on 2021/08/30.
//

import RxSwift
import RxTheme
import Rswift

protocol Theme {
    var mainColor: UIColor { get }
}

protocol FontTheme {
    var appFont: UIFont { get }
}

struct GreenTheme: Theme {
    let mainColor: UIColor = R.color.themeGreenColor()!
}

struct BlueTheme: Theme {
    let mainColor: UIColor = R.color.themeBlueColor()!
}

enum ThemeType: ThemeProvider {
    case green, blue
    var associatedObject: Theme {
        switch self {
        case .green:
            return GreenTheme()
        case .blue:
            return BlueTheme()
        }
    }
}

let themeService = ThemeType.service(initial: .green)
func themed<T>(_ mapper: @escaping ((Theme) -> T)) -> Observable<T> {
  return themeService.attrStream(mapper)
}
