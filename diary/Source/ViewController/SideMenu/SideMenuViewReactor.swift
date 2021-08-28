//
//  SideMenuViewReactor.swift
//  diary
//
//  Created by 김부성 on 2021/08/28.
//

import Foundation

import ReactorKit
import RxCocoa
import RxFlow

final class SideMenuViewReactor: Reactor, Stepper {

    var steps = PublishRelay<Step>()
    
    var initialState: State
    
    enum Action {
        case dismiss
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
        
        case .dismiss:
            steps.accept(DiaryStep.dismiss)
            return Observable.empty()
            
        }
    }
    
    
    
}
