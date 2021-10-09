//
//  AppearanceSelectReactor.swift
//  diary
//
//  Created by 김부성 on 2021/10/07.
//

import Foundation

import ReactorKit
import RxRelay
import RxFlow

final class AppearanceSelectReactor: Reactor, Stepper {
    let steps: PublishRelay<Step>
    
    let initialState: State
    
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        var image: UIImage
        var title: String
    }
    
    init(model: AppearnceModel, steps: PublishRelay<Step>) {
        self.initialState = State(image: model.image, title: model.title)
        self.steps = steps
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        
    }
}

