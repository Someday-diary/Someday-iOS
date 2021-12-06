//
//  SearchReactor.swift
//  diary
//
//  Created by 김부성 on 2021/11/06.
//

import Foundation

import ReactorKit
import RxRelay

final class SearchReactor: Reactor {
    
    let initialState: State
    
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        var date: String
        var content: String
        var tags: String
    }
    
    init(diary: Diary) {
        self.initialState = State(date: diary.date, content: diary.data, tags: diary.tags)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        
    }
}
