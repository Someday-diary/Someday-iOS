//
//  FSCalendar+RxTheme.swift
//  diary
//
//  Created by 김부성 on 2021/08/30.
//

import UIKit

import RxTheme
import RxSwift
import RxCocoa
import FSCalendar

extension ThemeProxy where Base: FSCalendarAppearance {
    var selectionColor: Observable<UIColor?> {
        get { return .empty() }
        set {
            let disposable = newValue
                // DisposeBag 사용불가
                .takeUntil(base.rx.deallocating)
                .observeOn(MainScheduler.instance)
                .bind(to: base.rx.selectionColor)
            hold(disposable, for: "selectionColor")
        }
    }
    
}

extension Reactive where Base: FSCalendarAppearance {
    
    var selectionColor: Binder<UIColor?> {
        return Binder(self.base) { view, attr in
            view.selectionColor = attr
        }
    }
    
}
