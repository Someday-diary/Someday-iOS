//
//  Theme.swift
//  diary
//
//  Created by 김부성 on 2021/10/20.
//

import UIKit
import Then

struct ThemeModel: Then {
    var firstColor: UIColor
    var secondColor: UIColor
    var thirdColor: UIColor
    var isSelected: Bool
    
    init(firstColor: UIColor, secondColor: UIColor, thirdColor: UIColor, isSelected: Bool) {
        self.firstColor = firstColor
        self.secondColor = secondColor
        self.thirdColor = thirdColor
        self.isSelected = isSelected
    }
}
