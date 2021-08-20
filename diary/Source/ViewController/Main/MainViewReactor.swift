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

class MainViewReactor: Reactor, Stepper {
    
    var steps: PublishRelay<Step> = PublishRelay<Step>()
    
    enum Action {
        case <#case#>
    }
    
    enum Mutation {
        case <#case#>
    }
    
    struct State {
        
    }
    
    var initialState: State
    
    init() {
        self.initialState = State()
    }
    
    
    func mutate(action: Action) -> Observable<Mutation> {
        <#code#>
    }
}
