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
import SwiftMessages

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
        case getBioCode
    }
    
    enum Mutation {
        case reEnterPasscode(String, String)
        case removePasscode
    }
    
    struct State {
        var type: PasscodeType
        var message: String = "Enter passcode".localized
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
                    return .just(Mutation.reEnterPasscode("Re-enter passcode".localized, passcode))
                } else if self.currentState.passcode == passcode {
                    authService.setPasscode(passcode: passcode)
                    HapticFeedback.notificationFeedback(type: .success)
                    self.steps.accept(DiaryStep.popViewController)
                } else {
                    return .just(Mutation.removePasscode)
                }
                
            case .update:
                if self.currentState.passcode.isEmpty && self.authService.currentPasscode == passcode {
                    HapticFeedback.notificationFeedback(type: .success)
                    self.authService.removePasscode()
                    return .just(Mutation.reEnterPasscode("Enter new passcode".localized, ""))
                } else {
                    HapticFeedback.notificationFeedback(type: .error)
                    return .just(Mutation.reEnterPasscode("Incorrect passcord, Re-enter passcode".localized, ""))
                }
                
            case .use:
                if self.authService.currentPasscode == passcode {
                    HapticFeedback.notificationFeedback(type: .success)
                    self.steps.accept(DiaryStep.mainIsRequired)
                } else {
                    HapticFeedback.notificationFeedback(type: .error)
                    return .just(Mutation.reEnterPasscode("Incorrect passcord, Re-enter passcode".localized, ""))
                }
                
            }
            return .empty()
            
        case .getBioCode:
            if UserDefaults.standard.bool(forKey: "bioPasscode") && currentState.type == .use {
                
                self.authService.getBioPasscode {
                    if $0 == true {
                        HapticFeedback.notificationFeedback(type: .success)
                        self.steps.accept(DiaryStep.mainIsRequired)
                    } else {
                        HapticFeedback.notificationFeedback(type: .error)
                    }
                }
            }
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case let .reEnterPasscode(message, passcode):
            if message == "Enter new passcode".localized {
                state.type = .create
            }
            state.message = message
            state.passcode = passcode
            
        case .removePasscode:
            HapticFeedback.impactFeedback()
            state.message = "Incorrect Passcord, Enter new passcode".localized
            state.passcode = ""
        }
        
        return state
    }
    
}
