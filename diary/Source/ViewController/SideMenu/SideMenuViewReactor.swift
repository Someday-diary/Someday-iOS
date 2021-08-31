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
    
    enum Action {
        case changeTheme(ThemeType)
        case dismiss
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    let initialState: State
    
    init() {
        self.initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        case let .changeTheme(theme):
            themeService.switch(theme)
            return Observable.empty()
            
        case .dismiss:
            steps.accept(DiaryStep.dismiss)
            return Observable.empty()
            
        }
    }
    
    
    
}
