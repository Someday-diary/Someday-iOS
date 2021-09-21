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
    
    var hashtagColor: Observable<UIColor?> {
        get { return .empty() }
        set {
            let disposable = newValue
                .takeUntil(base.rx.deallocating)
                .observeOn(MainScheduler.instance)
                .bind(to: base.rx.hashtagColor)
            hold(disposable, for: "hashtagColor")
        }
    }
}

extension Reactive where Base: ActiveLabel {
    
    var hashtagColor: Binder<UIColor?> {
        return Binder(self.base) { view, attr in
            view.hashtagColor = attr ?? .black
        }
    }
}
