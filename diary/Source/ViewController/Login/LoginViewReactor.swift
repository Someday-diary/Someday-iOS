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
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    init() {
        self.initialState = State()
    }
}
