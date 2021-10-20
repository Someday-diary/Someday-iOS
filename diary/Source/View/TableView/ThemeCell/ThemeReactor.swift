//
//  ThemeReactor.swift
//  diary
//
//  Created by 김부성 on 2021/10/07.
//

import UIKit

import ReactorKit
import RxRelay

final class ThemeReactor: Reactor {
    
    let initialState: State
    
    typealias Action = NoAction
    
    enum Mutration {
        
    }
    
    struct State {
        var firstColor: UIColor
        var secondColor: UIColor
        var thridColor: UIColor
        var isSelected: Bool
    }
    
    init(model: ThemeModel) {
        self.initialState = State(firstColor: model.firstColor, secondColor: model.secondColor, thridColor: model.thirdColor, isSelected: model.isSelected)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        
    }
}

