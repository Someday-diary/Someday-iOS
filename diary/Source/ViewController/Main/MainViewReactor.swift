//
//  MainViewReactor.swift
//  diary
//
//  Created by 김부성 on 2021/08/20.
//
import UIKit

import ReactorKit
import RxRelay
import RealmSwift
import RxFlow

final class MainViewReactor: Reactor, Stepper {
    
    var steps = PublishRelay<Step>()
    
    enum Action {
        case changeDay(Date)
        case changeColor([UIColor])
        case changeMonth(Date)
        case presentFloatingPanel
        case presentSideMenu
    }
    
    enum Mutation {
        case setColor([UIColor])
        case setLoading(Bool)
        case setMonth(Date)
        case changeWritedDays([RealmDiary])
    }
    
    struct State {
        var themeColor: [UIColor]?
        var writedDays: [Date] = []
        var month: Date = Date()
        var isLoading: Bool = false
    }
    
    let initialState: State
    let userService: UserServiceType
    let realmService: RealmServiceType
    
    init(userService: UserServiceType, realmService: RealmServiceType) {
        self.initialState = State()
        
        self.userService = userService
        self.realmService = realmService
    }
    
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .presentFloatingPanel:
            self.steps.accept(DiaryStep.floatingPanelIsRequird)
            return Observable.empty()
            
        case let .changeColor(newColor):
            return Observable.just(Mutation.setColor(newColor))
            
        case let .changeDay(newDay):
            return Observable.just(userService.updateDate(to: newDay))
                .flatMap { _ in Observable.empty() }
            
        case let .changeMonth(newMonth):
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                
                Observable.just(Mutation.setMonth(newMonth)),
                
                realmService.read(query: NSPredicate(format: "date CONTAINS %@", newMonth.toMonthString))
                    .asObservable()
                    .flatMap { result in Observable.just(Mutation.changeWritedDays(result)).catchErrorJustReturn(Mutation.changeWritedDays([])) },
                
                Observable.just(Mutation.setLoading(false))
            ])
            
        case .presentSideMenu:
            self.steps.accept(DiaryStep.sideMenuIsRequired)
            return Observable.empty()
            
        }
    }
    
    // update state
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
            
        case let .setColor(newColor):
            state.themeColor = newColor
            
        case let .changeWritedDays(month):
            state.writedDays = month.map { $0.date.realmDate }
            
        case let .setMonth(month):
            state.month = month
            
        case let .setLoading(isLoading):
            state.isLoading = isLoading
        }
        
        return state
    }
}
