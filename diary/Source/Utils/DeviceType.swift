//
//  DeviceType.swift
//  diary
//
//  Created by 김부성 on 2021/08/20.
//

import Foundation

enum DeviceType {
    case iPhoneSE
    case iPhoneSE2
    case iPhone13Pro
    case iPhone13ProMax
    case iPhone13mini

    func name() -> String {
        switch self {
        case .iPhoneSE:
            return "iPhone SE"
        case .iPhoneSE2:
            return "iPhone SE 2nd generation"
        case .iPhone13Pro:
            return "iPhone 13 Pro"
        case .iPhone13ProMax:
            return "iPhone 13 Pro Max"
        case .iPhone13mini:
            return "iPhone 13 mini"
        }
    }
}
