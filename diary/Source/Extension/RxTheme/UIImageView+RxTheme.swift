//
//  UIImageView+RxTheme.swift
//  diary
//
//  Created by 김부성 on 2021/09/01.
//

import UIKit

import RxSwift
import RxCocoa
import RxTheme

extension ThemeProxy where Base: UIImageView {
    var image: Observable<UIImage?> {
        get { return .empty() }
        set {
            let disposable = newValue
                .takeUntil(base.rx.deallocating)
                .observeOn(MainScheduler.instance)
                .bind(to: base.rx.image)
            hold(disposable, for: "image")
        }
    }
    
}

extension Reactive where Base: UIImageView {
    
    var image: Binder<UIImage?> {
        return Binder(self.base) { view, attr in
            view.image = attr
        }
    }
    
}
