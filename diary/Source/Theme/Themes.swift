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
    var subColor: UIColor { get }
    var thirdColor: UIColor { get }
    var buttonDisableColor: UIColor { get }
}

extension Theme {
    var buttonDisableColor: UIColor { R.color.diaryButtonDisabled()! }
}

struct GreenTheme: Theme {
    let mainColor: UIColor = R.color.greenThemeMainColor()!
    let subColor: UIColor = R.color.greenThemeSubColor()!
    let thirdColor: UIColor = R.color.greenThemeThirdColor()!
}

struct BlueTheme: Theme {
    let mainColor: UIColor = R.color.themeBlueColor()!
    let subColor: UIColor = R.color.themeBlueColor()!
    let thirdColor: UIColor = R.color.themeBlueColor()!
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
