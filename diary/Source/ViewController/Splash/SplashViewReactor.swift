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
    
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    let initialState: State = State()
    
    init() {
        
    }
    
    
}
