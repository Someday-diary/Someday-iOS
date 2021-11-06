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
        case setLoading(Bool)
    }
    
    struct State {
        var id: String = ""
        var password: String = ""
        var isLoading: Bool = false
        
        var idValidation: CheckValidation?
        var passwordValidation: CheckValidation?
    }
    
    let authService: AuthServiceType
    
    init(authService: AuthServiceType) {
        self.initialState = State()
        
        self.authService = authService
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        case let .updateTextField(data):
            return Observable.just(Mutation.checkValids(data))
            
        case .login:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                
                self.authService.login(self.currentState.id, self.currentState.password)
                    .map { result in
                        switch result {
                        case .success:
                            self.steps.accept(DiaryStep.mainIsRequired)
                        case let .error(error):
                            print(error)
                        }
                    }.asObservable().flatMap { _ in Observable.empty() },
                
                Observable.just(Mutation.setLoading(false))
            ])
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
            
        case let .setLoading(isLoading):
            state.isLoading = isLoading
        }
        
        return state
    }
}
