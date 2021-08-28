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
        case updateTextField([String])
        case login
    }
    
    enum Mutation {
        case checkValids([String])
    }
    
    struct State {
        var id: String = ""
        var password: String = ""
        
        var idValidation: CheckValidation?
        var passwordValidation: CheckValidation?
        
    }
    
    init() {
        self.initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        case let .updateTextField(data):
            return Observable.just(Mutation.checkValids(data))
        
        case .login:
            steps.accept(DiaryStep.mainIsRequired)
            return Observable.empty()
        
        }
        
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        
        var state = state
        
        switch mutation {
        case let .checkValids(data):
            state.id = data[0]
            state.password = data[1]
            
            state.idValidation = state.id.isValidEmail
            state.passwordValidation = state.password.isValidPassword
        }
        
        return state
    }
}
