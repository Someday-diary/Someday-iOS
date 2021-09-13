//
//  UserService.swift
//  diary
//
//  Created by 김부성 on 2021/09/13.
//

import Foundation
import RxSwift

enum UserEvent {
    case updateDate(Date)
}

protocol UserServiceType {
    var event: PublishSubject<UserEvent> { get }
    func updateDate(to date: Date) -> Observable<Date>
}

class UserService: UserServiceType {
    var event = PublishSubject<UserEvent>()
    
    func updateDate(to date: Date) -> Observable<Date> {
        event.onNext(.updateDate(date))
        return Observable.just(date)
    }
}
