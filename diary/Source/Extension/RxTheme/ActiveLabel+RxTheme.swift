//
//  ActiveLabel+RxTheme.swift
//  diary
//
//  Created by 김부성 on 2021/09/21.
//

import Foundation

import RxSwift
import RxCocoa
import RxTheme
import ActiveLabel

extension ThemeProxy where Base: ActiveLabel {
    
    var customColor: Observable<UIColor?> {
        get { return .empty() }
        set {
            let disposable = newValue
                .takeUntil(base.rx.deallocating)
                .observeOn(MainScheduler.instance)
                .bind(to: base.rx.customColor)
            hold(disposable, for: "customColor")
        }
    }
}

extension Reactive where Base: ActiveLabel {
    
    var customColor: Binder<UIColor?> {
        return Binder(self.base) { view, attr in
            view.customColor[.custom(pattern: "#[\\p{L}0-9_-]*")] = attr ?? .black
        }
    }
}
