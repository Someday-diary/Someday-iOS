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
    case deleteDiary
}

protocol UserServiceType {
    var event: PublishSubject<UserEvent> { get }
    func updateDate(to date: Date) -> Observable<Date>
    func deleteDiary() -> Observable<Void>
}

class UserService: UserServiceType {
    var event = PublishSubject<UserEvent>()
    
    func updateDate(to date: Date) -> Observable<Date> {
        event.onNext(.updateDate(date))
        return Observable.just(date)
    }
    
    func deleteDiary() -> Observable<Void> {
        event.onNext(.deleteDiary)
        return Observable.just(Void())
    }
}
