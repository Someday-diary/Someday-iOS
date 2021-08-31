//
//  MainViewReactor.swift
//  diary
//
//  Created by 김부성 on 2021/08/20.
//

import RxSwift
import RxCocoa
import ReactorKit
import RxFlow

final class MainViewReactor: Reactor, Stepper {
    
    var steps = PublishRelay<Step>()
    
    enum Action {
        case setDay(Date)
        case presentSideMenu
    }
    
    enum Mutation {
        case changeDay(Date)
    }
    
    struct State {
        var selectedDay: Date = Date()
        var themeColor: UIColor?
    }
    
    let initialState: State
    let themeService: ThemeServiceType
    
    init(themeService: ThemeServiceType) {
        self.initialState = State()
        self.themeService = themeService
    }
    
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {

        case let .setDay(selectedDay):
            return Observable.just(Mutation.changeDay(selectedDay))
        
        case .presentSideMenu:
            steps.accept(DiaryStep.sideMenuIsRequired)
            return Observable.empty()
        }
    }
    
    // update state
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case let .changeDay(selectedDay):
            state.selectedDay = selectedDay
        }
        
        return state
    }
}
