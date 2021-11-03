//
//  SideMenuViewReactor.swift
//  diary
//
//  Created by 김부성 on 2021/08/28.
//

import Foundation

import ReactorKit
import RxCocoa
import RxFlow

final class SideMenuViewReactor: Reactor, Stepper {

    var steps = PublishRelay<Step>()
    
    enum Action {
        case dismiss
        case logout
        case setTheme
        case setAlarm
        case setLock
        case showInfo
        case userFeedBack
        case disappear
    }
    
    enum Mutation {
        
    }
    
    struct State {
        var date: Date
    }
    
    let initialState: State
    fileprivate let authService: AuthServiceType
    
    init(date: Date, authService: AuthServiceType) {
        self.initialState = State(date: date)
        self.authService = authService
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
            
        case .dismiss:
            self.steps.accept(DiaryStep.dismiss)
            self.steps.accept(DiaryStep.floatingPanelIsRequired(currentState.date))
            return Observable.empty()
            
        case .logout:
            self.authService.logout()
            self.steps.accept(DiaryStep.dismiss)
            self.steps.accept(DiaryStep.splashIsRequired)
            return Observable.empty()
            
        case .setTheme:
            self.steps.accept(DiaryStep.dismiss)
            self.steps.accept(DiaryStep.themeIsRequired)
            return Observable.empty()
            
        case .setAlarm:
            return Observable.empty()
            
        case .setLock:
            return Observable.empty()
            
        case .showInfo:
            return Observable.empty()
        
        case .userFeedBack:
            return Observable.empty()
            
        case .disappear:
            return Observable.empty()
            
        }
    }
    
    
    
}
