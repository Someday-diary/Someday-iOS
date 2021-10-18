//
//  ThemeReactor.swift
//  diary
//
//  Created by 김부성 on 2021/10/07.
//

import Foundation

import ReactorKit
import RxRelay

final class ThemeReactor: Reactor {
    
    let initialState: State
    
    typealias Action = NoAction
    
    enum Mutation {
        
    }
    
    struct State {
        var image: UIImage
        var title: String
        var isSelected: Bool
    }
    
    init(model: AppearnceModel) {
        self.initialState = State(image: model.image, title: model.title, isSelected: model.isSelected)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        
    }
}

