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
        case updateDate(Date)
    }
    
    struct State {
        var selectedDay: Date
    }
    
    let userService: UserServiceType
    
    init(userService: UserServiceType, date: Date) {
        self.initialState = State(selectedDay: date)
        
        self.userService = userService
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .write:
            self.steps.accept(DiaryStep.writeIsRequired(self.currentState.selectedDay))
            return Observable.empty()
        }
    }
    
    // Global State
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let eventMutation = userService.event.flatMap { event -> Observable<Mutation> in
            switch event {
            case let .updateDate(newDay):
                return Observable.just(Mutation.updateDate(newDay))
            }
        }
        
        return Observable.merge(mutation, eventMutation)
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case let .updateDate(newDay):
            state.selectedDay = newDay
        }
        
        return state
    }
}
