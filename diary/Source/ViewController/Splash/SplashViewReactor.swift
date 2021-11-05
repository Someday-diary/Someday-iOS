//
//  SplashViewReactor.swift
//  diary
//
//  Created by 김부성 on 2021/08/25.
//

import Foundation
import ReactorKit
import RxRelay
import RxFlow

class SplashViewReactor: Reactor, Stepper {
    var steps = PublishRelay<Step>()
    
    let initialState: State
    
    enum Action {
        case setNextView
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    fileprivate let authService: AuthServiceType
    
    init(authService: AuthServiceType) {
        self.initialState = State()
        self.authService = authService
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .setNextView:
            if self.authService.currentToken == nil {
                self.steps.accept(DiaryStep.loginIsRequired)
                return Observable.empty()
            } else {
                self.steps.accept(DiaryStep.mainIsRequired)
                return Observable.empty()
            }
        }
    }
    
}
