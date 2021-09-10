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

final class RxFSCalendarDelegateProxy: CustomDelegateProxy<FSCalendar, FSCalendarDelegateAppearance>, DelegateProxyType, FSCalendarDelegateAppearance {
    
    static func registerKnownImplementations() {
        self.register { (calendar) -> RxFSCalendarDelegateProxy in
            RxFSCalendarDelegateProxy(parentObject: calendar, delegateProxy: self)
        }
    }

    static func currentDelegate(for object: FSCalendar) -> FSCalendarDelegateAppearance? {
        return object.delegate as? FSCalendarDelegateAppearance
    }

    static func setCurrentDelegate(_ delegate: FSCalendarDelegateAppearance?, to object: FSCalendar) {
        object.delegate = delegate
    }
}


extension Reactive where Base: FSCalendar {
    var delegate: DelegateProxy<FSCalendar, FSCalendarDelegateAppearance> {
        return RxFSCalendarDelegateProxy.proxy(for: self.base)
    }
    
    var didSelect: Observable<Date> {
        return delegate.methodInvoked(#selector(FSCalendarDelegateAppearance.calendar(_:didSelect:at:)))
            .map { (params) in
                // date time adding
                let date = params[1] as! Date
                let newDate = date.addingTimeInterval(TimeInterval(TimeZone.current.secondsFromGMT(for: date)))
                return newDate
            }
    }
    
    var calendarCurrentPageDidChange: Observable<FSCalendar> {
        return delegate.methodInvoked(#selector(FSCalendarDelegateAppearance.calendarCurrentPageDidChange(_:)))
            .map { (params) in
                return params[0] as! FSCalendar
            }
    }
    
    func setDelegate(_ delegate: FSCalendarDelegateAppearance) -> Disposable {
        return RxFSCalendarDelegateProxy.installForwardDelegate(delegate, retainDelegate: false, onProxyForObject: self.base)
     }
}
