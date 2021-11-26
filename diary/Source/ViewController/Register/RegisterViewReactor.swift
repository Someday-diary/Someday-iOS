//
//  SignUpReactor.swift
//  diary
//
//  Created by 김부성 on 2021/11/08.
//

import Foundation

import RxFlow
import RxRelay
import ReactorKit
import SwiftMessages

final class RegisterViewReactor: Reactor, Stepper {
    
    var steps = PublishRelay<Step>()
    
    var initialState: State
    
    enum Action {
        case updateTextField([String])
        case next
        case sendCode
        case login
    }
    
    enum Mutation {
        case checkValids([String])
        case setLoading(Bool)
    }
    
    struct State {
        var email: String = ""
        var code: String = ""
        var isLoading: Bool = false
        
        var emailValidation: CheckValidation?
        var codeValidation: CheckValidation?
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
            
        case .next:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                
                self.authService.confirmEmail(self.currentState.email, self.currentState.code)
                    .map { result in
                        switch result {
                        case .success:
                            self.steps.accept(DiaryStep.passwordIsRequired(self.currentState.email))
                        case let .error(error):
                            print(error)
                            SwiftMessages.show(config: Message.diaryConfig, view: Message.faildView(error.message))
                        }
                    }.asObservable().flatMap { _ in Observable.empty() },
                
                Observable.just(Mutation.setLoading(false))
            ])
            
        case .sendCode:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                
                self.authService.verifyEmail(self.currentState.email)
                    .map { result in
                        switch result {
                        case .success:
                            SwiftMessages.show(config: Message.diaryConfig, view: Message.successView("코드가 성공적으로 전송되었습니다."))
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
            state.email = data[0]
            state.code = data[1]
            
            state.emailValidation = state.email.isValidEmail
            state.codeValidation = state.code.isValidCode
            
        case let .setLoading(isLoading):
            state.isLoading = isLoading
        }
        
        return state
    }
}
