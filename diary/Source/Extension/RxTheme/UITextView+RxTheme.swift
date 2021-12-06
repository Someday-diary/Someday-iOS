//
//  UITextView+RxTheme.swift
//  diary
//
//  Created by 김부성 on 2021/09/05.
//

import UIKit

import RxSwift
import RxCocoa
import UITextView_Placeholder
import RxTheme

extension ThemeProxy where Base: UITextView {
    
    var placeholderColor: Observable<UIColor?> {
        get { return .empty() }
        set {
            let disposable = newValue
                .takeUntil(base.rx.deallocating)
                .observeOn(MainScheduler.instance)
                .bind(to: base.rx.placeholderColor)
            hold(disposable, for: "placeholderColor")
        }
    }
    
}

extension Reactive where Base: UITextView {
    
    var placeholderColor: Binder<UIColor?> {
        return Binder(self.base) { view, attr in
            view.placeholderColor = attr
        }
    }
    
}
