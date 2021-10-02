//
//  CGFloat.swift
//  diary
//
//  Created by 김부성 on 2021/10/02.
//

import Foundation

extension CGFloat {
    var iPhoneSETop: Int {
        guard self < 30 else { return Int(self) }
        return 15
    }
}
