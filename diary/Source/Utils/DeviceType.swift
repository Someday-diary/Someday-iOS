//
//  DeviceType.swift
//  diary
//
//  Created by 김부성 on 2021/08/20.
//

import Foundation

enum DeviceType {
    case iPhoneSE2
    case iPhone8
    case iPhone12Pro
    case iPhone12ProMax
    case iPhone12mini

    func name() -> String {
        switch self {
        case .iPhoneSE2:
            return "iPhone SE"
        case .iPhone8:
            return "iPhone 8"
        case .iPhone12Pro:
            return "iPhone 12 Pro"
        case .iPhone12ProMax:
            return "iPhone 12 Pro Max"
        case .iPhone12mini:
            return "iPhone 12 mini"
        }
    }
}
