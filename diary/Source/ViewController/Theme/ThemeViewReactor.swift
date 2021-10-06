//
//  ThemeViewReactor.swift
//  diary
//
//  Created by 김부성 on 2021/10/06.
//

import Foundation

import ReactorKit
import RxRelay
import RxFlow

final class ThemeViewReactor: Reactor, Stepper {
    var steps = PublishRelay<Step>()
    
    let initialState: State
    
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    init() {
        self.initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        
    }
}
