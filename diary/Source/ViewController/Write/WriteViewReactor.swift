//
//  WriteViewReactor.swift
//  diary
//
//  Created by 김부성 on 2021/09/04.
//

import Foundation

import ReactorKit
import RxRelay
import RxFlow

final class WriteViewReactor: Reactor, Stepper {
    
    var steps = PublishRelay<Step>()
    
    
    enum Action {
        case popViewController
        case saveDidary(String, String)
    }
    
    enum Mutation {
        case setLoading(Bool)
    }
    
    struct State {
        var date: Date
        var data: String
        var tags: String
        var isLoading: Bool = false
    }
    
    let initialState: State
    let realmService: RealmServiceType
    
    init(date: Date, diary: RealmDiary?, realmService: RealmServiceType) {
        if diary != nil {
            self.initialState = State(date: date, data: diary!.data, tags: diary!.tags)
        } else {
            self.initialState = State(date: date, data: String(), tags: String())
        }
        
        self.realmService = realmService
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        
        case .popViewController:
            self.steps.accept(DiaryStep.popViewController)
            return Observable.empty()
            
        case let .saveDidary(data, tags):
            
            
            
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                
                self.realmService.write(self.currentState.date, data, tags)
                    .do(onSuccess: {
                        print("일기 저장 성공")
                        self.steps.accept(DiaryStep.popViewController)
                    },onError: { error in
                        print("error")
                    }).asObservable().flatMap { _ in Observable.empty() },
                
                Observable.just(Mutation.setLoading(false))
            ])
            
        }
        
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case let .setLoading(isLoading):
            state.isLoading = isLoading
        }
        
        return state
    }
    
}
