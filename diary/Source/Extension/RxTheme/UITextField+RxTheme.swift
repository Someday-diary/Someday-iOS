//
//  UITextField+RxTheme.swift
//  diary
//
//  Created by 김부성 on 2021/10/05.
//

import UIKit

import RxSwift
import RxCocoa
import RxTheme

extension ThemeProxy where Base: UITextField {
    
    var clearButtonTintColor: Observable<UIColor?> {
        get { return .empty() }
        set {
            let disposable = newValue
                .takeUntil(base.rx.deallocating)
                .observeOn(MainScheduler.instance)
                .bind(to: base.rx.clearButtonTintColor)
            hold(disposable, for: "clearButtonTintColor")
        }
    }
}

extension Reactive where Base: UITextField {
    
    var clearButtonTintColor: Binder<UIColor?> {
        return Binder(self.base) { view, attr in
            view.clearButtonTintColor = attr
        }
    }
}
