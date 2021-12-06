//
//  Int.swift
//  diary
//
//  Created by 김부성 on 2021/11/05.
//

import Foundation

extension Int {
    var switchAction: FloatingViewReactor.Action {
        switch self {
        case 0:
            return FloatingViewReactor.Action.edit
        case 1:
            return FloatingViewReactor.Action.delete
        default:
            return FloatingViewReactor.Action.cancel
        }
    }
}

