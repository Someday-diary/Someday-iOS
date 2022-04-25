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
    
    var clearButtonTintColor: ThemeAttribute<UIColor?> {
        get { fatalError("set only") }
        set {
            base.clearButtonTintColor = newValue.value
            let disposable = newValue.stream
                .take(until: base.rx.deallocating)
                .observe(on: MainScheduler.instance)
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
