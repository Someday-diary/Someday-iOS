//
//  WriteViewReactor.swift
//  diary
//
//  Created by 김부성 on 2021/09/04.
//

import Foundation

import RxSwift
import RxCocoa
import RxFlow
import ReactorKit

final class WriteViewReactor: Reactor, Stepper {
    
    var steps = PublishRelay<Step>()
    
    
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        var date: Date
    }
    
    let initialState: State
    
    init(_ date: Date) {
        self.initialState = State(date: date)
    }
    
}
