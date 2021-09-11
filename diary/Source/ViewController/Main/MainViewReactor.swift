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
        case presentWriteView
    }
    
    enum Mutation {
        case setDay(Date)
        case setColor([UIColor])
        case changeWritedDays(Date)
    }
    
    struct State {
        var selectedDay: Date = Date().today
        var themeColor: [UIColor]?
        var writedDays: [Date] = []
        var Month: Date = Date()
    }
    
    let initialState: State
    
    init() {
        self.initialState = State()
    }
    
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .presentFloatingPanel:
            self.steps.accept(DiaryStep.floatingPanelIsRequird)
            return Observable.empty()
            
        case let .changeColor(newColor):
            return Observable.just(Mutation.setColor(newColor))
            
        case let .changeDay(newDay):
            if currentState.writedDays.contains(newDay) { print("this is day") }
            return Observable.just(Mutation.setDay(newDay))
            
        case let .changeMonth(newmonth):
            return Observable.just(Mutation.changeWritedDays(newmonth))
            
        case .presentSideMenu:
            self.steps.accept(DiaryStep.sideMenuIsRequired)
            return Observable.empty()
            
        case .presentWriteView:
            self.steps.accept(DiaryStep.writeIsRequired(currentState.selectedDay))
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
            
        case let .changeWritedDays(newMonth):
            let dateFormatter = DateFormatter().then {
                $0.dateFormat = "yyyy-MM"
            }
            let monthStr = dateFormatter.string(from: newMonth)
            
            let realm = try! Realm()
            let query = NSPredicate(format: "date CONTAINS %@", monthStr)
            let result = realm.objects(RealmDiary.self).filter(query)
            
            state.writedDays = Array(result).map { $0.date.realmDate }
            state.Month = newMonth
            
        }
        
        return state
    }
}
