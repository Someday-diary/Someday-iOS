//
//  ThemeService.swift
//  diary
//
//  Created by 김부성 on 2021/08/31.
//

import Foundation
import RxSwift

enum ThemeEvent {
    case updateTheme
}

protocol ThemeServiceType {
    var event: PublishSubject<ThemeEvent> { get }
    func refreshTheme() -> Observable<Void>
}

class ThemeService: ThemeServiceType {
    
    let event = PublishSubject<ThemeEvent>()
    
    func refreshTheme() -> Observable<Void> {
        return .empty()
    }
    
}
