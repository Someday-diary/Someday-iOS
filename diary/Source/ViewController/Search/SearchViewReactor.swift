//
//  SearchViewReactor.swift
//  diary
//
//  Created by 김부성 on 2021/10/03.
//

import Foundation

import ReactorKit
import SwiftMessages
import RxRelay
import RxFlow

final class SearchViewReactor: Reactor, Stepper {
    var steps = PublishRelay<Step>()
    
    let initialState: State
    
    enum Action {
        case search(String)
        case popViewController
    }
    
    enum Mutation {
        case setLoading(Bool)
        case updateResponse([Diary])
    }
    
    struct State {
        var searchString: String
        var response: [Diary] = []
        var isLoading: Bool = false
    }
    
    fileprivate let diaryService: DiaryServiceType
    init(diaryService: DiaryServiceType) {
        self.initialState = State(searchString: "")
        
        self.diaryService = diaryService
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        case .popViewController:
            self.steps.accept(DiaryStep.popViewController)
            return Observable.empty()
            
        case let .search(string):
            return self.diaryService.getDiaryTag(string).asObservable()
                .map { result in
                    switch result {
                    case let .success(result):
                        return Mutation.updateResponse(result.posts!.map { $0.toDiary} )
                    case let .error(error):
                        print(error)
                        SwiftMessages.show(config: Message.diaryConfig, view: Message.faildView(error.message))
                        return Mutation.updateResponse([])
                    }
                }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case let .updateResponse(response):
            state.response = response
        case let .setLoading(isLoading):
            state.isLoading = isLoading
        }
        
        return state
    }
}
