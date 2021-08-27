//
//  LoginViewReactor.swift
//  diary
//
//  Created by 김부성 on 2021/08/25.
//

import Foundation
import RxFlow
import RxRelay
import ReactorKit

final class LoginViewReactor: Reactor, Stepper {
    
    var steps = PublishRelay<Step>()
    
    var initialState: State
    
    enum Action {
        case login
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    init() {
        self.initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .login:
            steps.accept(DiaryStep.mainIsRequired)
        return Observable.empty()
        }
    }
}
