//
//  DiaryTextField+Rx.swift
//  diary
//
//  Created by 김부성 on 2021/08/29.
//

import UIKit
import RxSwift
import RxCocoa
import RxAnimated

extension AnimatedSink where Base: DiaryTextField {
    
    var error: Binder<CheckValidation?> {
        let animation = self.type!
        return Binder(self.base) { textfield, validation in
            animation.animate(view: textfield.eventLabel, binding: {
                switch validation {
                case let .correct(type):
                    textfield.eventLabel.text = type.rawValue.localized
                case let .error(message):
                    textfield.eventLabel.text = message.localized
                default:
                    textfield.eventLabel.text = " "
                }
            })
        }
    }
}
