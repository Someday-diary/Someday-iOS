//
//  CGFloat.swift
//  diary
//
//  Created by 김부성 on 2021/10/02.
//

import UIKit

extension CGFloat {
    var loginTextFieldTop: Int {
        switch UIDevice().type {
        case .iPod7, .iPhoneSE2:
            return 15
        default:
            return Int(self)
        }
    }
    
    var loginTextFieldBetween: Int {
        switch UIDevice().type {
        case .iPod7, .iPhoneSE2:
            return 0
        default:
            return Int(self)
        }
    }
}
