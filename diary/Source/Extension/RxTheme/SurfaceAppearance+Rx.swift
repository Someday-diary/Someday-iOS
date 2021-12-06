//
//  SurfaceAppearance+Rx.swift
//  diary
//
//  Created by 김부성 on 2021/09/10.
//

import UIKit

import RxSwift
import RxCocoa
import FloatingPanel
import RxTheme

extension ThemeProxy where Base: SurfaceAppearance {
    
    var backgroundColor: Observable<UIColor?> {
        get { return .empty() }
        set {
            let disposable = newValue
                .takeUntil(base.rx.deallocating)
                .observeOn(MainScheduler.instance)
                .bind(to: base.rx.backgroundColor)
            hold(disposable, for: "backgroundColor")
        }
    }
}

extension Reactive where Base: SurfaceAppearance {
    
    var backgroundColor: Binder<UIColor?> {
        return Binder(self.base) { view, attr in
            view.backgroundColor = attr
        }
    }
}
