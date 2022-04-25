//
//  Themes.swift
//  diary
//
//  Created by 김부성 on 2021/08/30.
//

import RxSwift
import RxTheme
import Rswift
import UIKit

protocol Theme {
    var mainColor: UIColor { get }
    var subColor: UIColor { get }
    var thirdColor: UIColor { get }
    var diaryDisableColor: UIColor { get }
    var mainIllustration: UIImage { get }
    var systemWhiteColor: UIColor { get }
    var backgroundColor: UIColor { get }
    var clearColor: UIColor { get }
    var clearButtonColor: UIColor { get }
    var tableViewCellColor: UIColor { get }
}

extension Theme {
    var diaryDisableColor: UIColor { R.color.diaryDisabledColor()! }
    var systemWhiteColor: UIColor { R.color.systemWhiteColor()! }
    var backgroundColor: UIColor { R.color.diaryBackgroundColor()! }
    var clearColor: UIColor { .clear }
    var clearButtonColor: UIColor { R.color.clearButtonColor()! }
    var tableViewCellColor: UIColor { R.color.tableViewCellColor()! }
}

struct GreenTheme: Theme {
    let mainColor: UIColor = R.color.greenThemeMainColor()!
    let subColor: UIColor = R.color.greenThemeSubColor()!
    let thirdColor: UIColor = R.color.greenThemeThirdColor()!
    let mainIllustration: UIImage = R.image.mainIconGreenTheme()!
}

struct BlueTheme: Theme {
    let mainColor: UIColor = R.color.blueThemeMainColor()!
    let subColor: UIColor = R.color.blueThemeSubColor()!
    let thirdColor: UIColor = R.color.blueThemeThirdColor()!
    let mainIllustration: UIImage = R.image.mainIconBlueTheme()!
}

struct PurpleTheme: Theme {
    let mainColor: UIColor = R.color.purpleThemeMainColor()!
    let subColor: UIColor = R.color.purpleThemeSubColor()!
    let thirdColor: UIColor = R.color.purpleThemeThirdColor()!
    let mainIllustration: UIImage = R.image.mainIconPurpleTheme()!
}

struct YellowTheme: Theme {
    let mainColor: UIColor = R.color.yellowThemeMainColor()!
    let subColor: UIColor = R.color.yellowThemeSubColor()!
    let thirdColor: UIColor = R.color.yellowThemeThirdColor()!
    let mainIllustration: UIImage = R.image.mainIconYellowTheme()!
}

struct RedTheme: Theme {
    let mainColor: UIColor = R.color.redThemeMainColor()!
    let subColor: UIColor = R.color.redThemeSubColor()!
    let thirdColor: UIColor = R.color.redThemeThirdColor()!
    let mainIllustration: UIImage = R.image.mainIconRedTheme()!
}


enum ThemeType: ThemeProvider {
    case green, blue, purple, yellow, red
    var associatedObject: Theme {
        switch self {
        case .green:
            return GreenTheme()
        case .blue:
            return BlueTheme()
        case .purple:
            return PurpleTheme()
        case .yellow:
            return YellowTheme()
        case .red:
            return RedTheme()
        }
    }
}

let themeService = ThemeType.service(initial: .green)
