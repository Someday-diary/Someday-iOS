//
//  PasswordViewReactor.swift
//  diary
//
//  Created by 김부성 on 2021/11/08.
//

import Foundation

import RxFlow
import RxRelay
import ReactorKit
import SwiftMessages

final class PasswordViewReactor: Reactor, Stepper {
    
    var steps = PublishRelay<Step>()
    
    var initialState: State
    
    enum Action {
        case updateTextField([String])
        case next
        case login
    }
    
    enum Mutation {
        case checkValids([String])
        case setLoading(Bool)
    }
    
    struct State {
        var email: String
        var password: String = ""
        var reEnter: String = ""
        var isLoading: Bool = false
        
        var passwordValidation: CheckValidation?
        var reEnterValidation: CheckValidation?
    }
    
    let authService: AuthServiceType
    
    init(email: String, authService: AuthServiceType) {
        self.initialState = State(email: email)
        
        self.authService = authService
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        case let .updateTextField(data):
            return Observable.just(Mutation.checkValids(data))
            
        case .next:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                
                self.authService.register(self.currentState.email, self.currentState.reEnter, "Y")
                    .map { result in
                        switch result {
                        case .success:
                            SwiftMessages.show(config: Message.diaryConfig, view: Message.successView("Sign up Success!"))
                            self.steps.accept(DiaryStep.popToRootViewController)
                        case let .error(error):
                            print(error)
                            SwiftMessages.show(config: Message.diaryConfig, view: Message.faildView(error.message))
                        }
                    }.asObservable().flatMap { _ in Observable.empty() },
                
                Observable.just(Mutation.setLoading(false))
            ])
            
        case .login:
            self.steps.accept(DiaryStep.popToRootViewController)
            return Observable.empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        
        var state = state
        
        switch mutation {
        case let .checkValids(data):
            state.password = data[0]
            state.reEnter = data[1]
            
            state.passwordValidation = state.password.isValidPassword
            state.reEnterValidation = [state.password, state.reEnter].isValidReEnter
            
        case let .setLoading(isLoading):
            state.isLoading = isLoading
        }
        
        return state
    }
}
