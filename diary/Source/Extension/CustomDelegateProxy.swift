//
//  CustomDelegateProxy.swift
//  diary
//
//  Created by 김부성 on 2021/08/28.
//

import Foundation
import RxSwift
import RxCocoa

// selector nil error handling
class CustomDelegateProxy<P: AnyObject, D>: DelegateProxy<P, D> {
    override open func responds(to aSelector: Selector!) -> Bool {
        guard aSelector != nil else { return false }
        return super.responds(to: aSelector)
    }
}
