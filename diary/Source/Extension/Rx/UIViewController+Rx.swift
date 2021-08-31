//
//  UIViewController+Rx.swift
//  diary
//
//  Created by 김부성 on 2021/08/30.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    public var didRotate: ControlEvent<Void> {
        let source = self.methodInvoked(#selector(Base.didRotate(from:))).map { _ in }
        return ControlEvent(events: source)
    }
}
