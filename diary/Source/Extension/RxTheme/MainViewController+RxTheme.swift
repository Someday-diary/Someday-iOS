//
//  MainViewController+RxTheme.swift
//  diary
//
//  Created by 김부성 on 2021/08/31.
//

import UIKit

import RxTheme
import RxSwift
import RxCocoa
import FSCalendar

extension ThemeProxy where Base: MainViewController {
    var themeColor: Observable<UIColor?> {
        get { return .empty() }
        set {
            let disposable = newValue
                .takeUntil(base.rx.deallocating)
                .observeOn(MainScheduler.instance)
                .bind(to: base.rx.themeColor)
            hold(disposable, for: "themeColor")
        }
    }
}

extension Reactive where Base: MainViewController {
    
    var themeColor: Binder<UIColor?> {
        return Binder(self.base) { view, attr in
            view.themeColor = attr
        }
    }
    
}
