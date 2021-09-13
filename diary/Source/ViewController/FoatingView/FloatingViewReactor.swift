//
//  FloatingViewReactor.swift
//  diary
//
//  Created by 김부성 on 2021/09/10.
//

import Foundation

import ReactorKit
import RxRelay
import RxFlow

final class FloatingViewReactor: Reactor, Stepper {
    var steps = PublishRelay<Step>()
    
    let initialState: State
    
    enum Action {
        case write
    }
    
    enum Mutation {
        
    }
    
    struct State {
        var selectedDay: Date = Date().today
    }
    
    init() {
        self.initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .write:
            self.steps.accept(DiaryStep.writeIsRequired(self.currentState.selectedDay))
            return Observable.empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        
    }
}
