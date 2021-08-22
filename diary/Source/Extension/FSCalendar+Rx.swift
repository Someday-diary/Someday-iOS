//
//  FSCalendar+Rx.swift
//  diary
//
//  Created by 김부성 on 2021/08/21.
//

import Foundation
import RxSwift
import RxCocoa
import FSCalendar

// selector nil error handling
class MyDelegateProxy<P: AnyObject, D>: DelegateProxy<P, D> {
    override open func responds(to aSelector: Selector!) -> Bool {
        guard aSelector != nil else { return false }
        return super.responds(to: aSelector)
    }
}

class RxFSCalendarDelegateProxy: MyDelegateProxy<FSCalendar, FSCalendarDelegate>, DelegateProxyType, FSCalendarDelegate {
    static func registerKnownImplementations() {
        self.register { (calendar) -> RxFSCalendarDelegateProxy in
            RxFSCalendarDelegateProxy(parentObject: calendar, delegateProxy: self)
        }
    }
    
    static func currentDelegate(for object: FSCalendar) -> FSCalendarDelegate? {
        return object.delegate
    }
    
    static func setCurrentDelegate(_ delegate: FSCalendarDelegate?, to object: FSCalendar) {
        object.delegate = delegate
    }
}

extension Reactive where Base: FSCalendar {
    var delegate : DelegateProxy<FSCalendar, FSCalendarDelegate> {
        return RxFSCalendarDelegateProxy.proxy(for: self.base)
    }
    
    var didSelect : Observable<Date> {
        return delegate.methodInvoked(#selector(FSCalendarDelegate.calendar(_:didSelect:at:)))
            .map({ (params) in
                // date time adding
                let date = (params[1] as! Date).addingTimeInterval(3600 * 9)
                return date
            })
    }
}
