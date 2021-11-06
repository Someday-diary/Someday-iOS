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
        case presentSearch
        case presentSideMenu
    }
    
    enum Mutation {
        case setColor([UIColor])
        case setLoading(Bool)
        case setMonth(Date)
        case setCurrentDay(Date)
        case changeWritedDays([Posts])
    }
    
    struct State {
        var themeColor: [UIColor]?
        var writedDays: [Date] = []
        var currentDay: Date = Date().today
        var month: Date = Date()
        var isLoading: Bool = false
    }
    
    let initialState: State
    let userService: UserServiceType
    let diaryService: DiaryServiceType
    
    init(userService: UserServiceType, diaryService: DiaryServiceType) {
        self.initialState = State()
        
        self.userService = userService
        self.diaryService = diaryService
    }
    
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .presentFloatingPanel:
            self.steps.accept(DiaryStep.floatingPanelIsRequired(currentState.currentDay))
            return Observable.empty()
            
        case .presentSearch:
            self.steps.accept(DiaryStep.searchIsRequired)
            return Observable.empty()
            
        case let .changeColor(newColor):
            return Observable.just(Mutation.setColor(newColor))
            
        case let .changeDay(newDay):
            return Observable.just(userService.updateDate(to: newDay))
                .flatMap { _ in
                    Observable.just(Mutation.setCurrentDay(newDay))
                }
            
        case let .changeMonth(newMonth):
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                
                Observable.just(Mutation.setMonth(newMonth)),
                
                diaryService.getMonthDiary(newMonth.year, newMonth.month).asObservable()
                    .map { result in
                        switch result {
                        case let .success(result):
                            return Mutation.changeWritedDays(result.posts!)
                        case let .error(error):
                            print(error)
                            return Mutation.changeWritedDays([])
                        }
                    },
                
                Observable.just(Mutation.setLoading(false))
            ])
            
        case .presentSideMenu:
            self.steps.accept(DiaryStep.sideMenuIsRequired(currentState.currentDay))
            return Observable.empty()
            
        }
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let eventMutation = userService.event.flatMap { [weak self] event -> Observable<Mutation> in
            guard let self = self else { return Observable.empty() }
            
            switch event {
            
            case .deleteDiary:
                return Observable.concat([
                    Observable.just(Mutation.setLoading(true)),
                    
                    self.diaryService.getMonthDiary(self.currentState.month.year, self.currentState.month.month).asObservable()
                        .map { result in
                            switch result {
                            case let .success(result):
                                return Mutation.changeWritedDays(result.posts!)
                            case let .error(error):
                                print(error)
                                return Mutation.changeWritedDays([])
                            }
                        },
                    
                    Observable.just(Mutation.setLoading(false))
                ])
                
            default:
                return Observable<Mutation>.empty()
            }
        }
        
        return Observable.merge(mutation, eventMutation)
    }
    
    // update state
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
            
        case let .setColor(newColor):
            state.themeColor = newColor
            
        case let .changeWritedDays(posts):
            state.writedDays = posts.map { $0.date }
            
        case let .setMonth(month):
            state.month = month
            
        case let .setCurrentDay(currentDay):
            state.currentDay = currentDay
            
        case let .setLoading(isLoading):
            state.isLoading = isLoading
        }
        
        return state
    }
}
