//
//  PasscodeViewReactor.swift
//  diary
//
//  Created by 김부성 on 2021/11/09.
//

import ReactorKit
import RxCocoa
import RxSwift
import RxFlow

enum PasscodeType {
    case create
    case update
    case use
}

final class PasscodeViewReactor: Reactor, Stepper {
    var initialState: State
    
    var steps = PublishRelay<Step>()
    
    enum Action {
        case callBack(String)
    }
    
    enum Mutation {
        case reEnterPasscode(String, String)
        case removePasscode
    }
    
    struct State {
        var type: PasscodeType
        var message: String = "비밀번호를 입력하세요."
        var passcode: String = ""
        var newPasscode: String = ""
    }
    
    fileprivate let authService: AuthServiceType
    
    init(type: PasscodeType, authService: AuthServiceType) {
        self.initialState = State(type: type)
        
        self.authService = authService
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .callBack(passcode):
            switch self.currentState.type {
            case .create:
                if self.currentState.passcode.isEmpty {
                    return .just(Mutation.reEnterPasscode("비밀번호를 재입력하세요.", passcode))
                } else if self.currentState.passcode == passcode {
                    try? authService.setPasscode(passcode: passcode)
                    HapticFeedback.notificationFeedback(type: .error)
                    self.steps.accept(DiaryStep.popViewController)
                } else {
                    return .just(Mutation.removePasscode)
                }
                
            case .update:
                if self.currentState.passcode.isEmpty && self.authService.currentPasscode == passcode {
                    self.authService.removePasscode()
                    return .just(Mutation.reEnterPasscode("새로운 비밀번호를 입력해주세요.", ""))
                } else {
                    HapticFeedback.notificationFeedback(type: .error)
                    return .just(Mutation.reEnterPasscode("다시 입력해주세요.", ""))
                }
                
            case .use:
                if self.authService.currentPasscode == passcode {
                    HapticFeedback.notificationFeedback(type: .error)
                    self.steps.accept(DiaryStep.mainIsRequired)
                } else {
                    HapticFeedback.notificationFeedback(type: .error)
                    return .just(Mutation.reEnterPasscode("다시 입력해주세요.", ""))
                }
                
            }
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case let .reEnterPasscode(message, passcode):
            if message == "새로운 비밀번호를 입력해주세요." {
                state.type = .create
            }
            state.message = message
            state.passcode = passcode
            
        case .removePasscode:
            HapticFeedback.impactFeedback()
            state.message = "비밀번호를 입력하세요."
            state.passcode = ""
        }
        
        return state
    }
    
}
