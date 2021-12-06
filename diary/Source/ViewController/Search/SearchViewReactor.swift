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
        case updateResponse([Post], String)
    }
    
    struct State {
        var searchString: String
        var isLoading: Bool = false
        var isEmpty: Bool = true
        
        var searchSectionItmes: [SearchViewSectionItem] = []
        var sections: [SearchViewSection] = []
        var sectionDates: [Date] = []
    }
    
    fileprivate let diaryService: DiaryServiceType
    init(tag: String?, diaryService: DiaryServiceType) {
        if let tag = tag {
            self.initialState = State(searchString: tag)
        } else {
            self.initialState = State(searchString: "")
        }
        
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
                        return Mutation.updateResponse(result.posts!, string)
                    case let .error(error):
                        if error != .noDiary {
                            SwiftMessages.show(config: Message.diaryConfig, view: Message.faildView(error.message))
                        }
                        return Mutation.updateResponse([], string)
                    }
                }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case let .updateResponse(response, string):
            state.searchString = string
            var month: [Date : [Diary]] = [:]
            response.forEach {
                let date = String($0.date.dropLast(3)).monthToDate
                if var diarys = month[date] {
                    diarys.append($0.toDiary)
                    month[date] = diarys
                } else {
                    month[date] = [$0.toDiary]
                }
            }
            state.sections.removeAll()
            state.sectionDates.removeAll()
            
            month.sorted { $0.key > $1.key }.forEach {
                let items: [SearchViewSectionItem] = $0.value.map { .diary(SearchReactor(diary: $0)) }
                state.sections.append(.diary(items))
                state.sectionDates.append($0.key)
            }
            
            state.isEmpty = state.sections.isEmpty
            
        case let .setLoading(isLoading):
            state.isLoading = isLoading
        }
        
        return state
    }
}
