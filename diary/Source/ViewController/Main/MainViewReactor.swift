//
//  MainViewReactor.swift
//  diary
//
//  Created by 김부성 on 2021/08/20.
//
import UIKit

import RxSwift
import RxCocoa
import ReactorKit
import RxFlow

final class MainViewReactor: Reactor, Stepper {
    
    var steps = PublishRelay<Step>()
    
    enum Action {
        case changeDay(Date)
        case changeColor([UIColor])
        case presentSideMenu
    }
    
    enum Mutation {
        case setDay(Date)
        case setColor([UIColor])
    }
    
    struct State {
        var selectedDay: Date = Date()
        var themeColor: [UIColor]?
    }
    
    let initialState: State
    
    init() {
        self.initialState = State()
    }
    
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        
        case let .changeColor(newColor):
            return Observable.just(Mutation.setColor(newColor))

        case let .changeDay(newDay):
            return Observable.just(Mutation.setDay(newDay))
        
        case .presentSideMenu:
            self.steps.accept(DiaryStep.sideMenuIsRequired)
            return Observable.empty()
        }
    }
    
    // update state
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        
        case let .setDay(newDay):
            state.selectedDay = newDay
            
        case let .setColor(newColor):
            state.themeColor = newColor
        }
        
        return state
    }
}
