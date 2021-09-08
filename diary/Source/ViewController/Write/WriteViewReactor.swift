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
import RealmSwift
import ReactorKit

final class WriteViewReactor: Reactor, Stepper {
    
    var steps = PublishRelay<Step>()
    
    
    enum Action {
        case popViewController
        case writeDiary(String, String)
        case saveDidary
    }
    
    enum Mutation {
        case updateDiary(String, String)
    }
    
    struct State {
        var date: Date
        var data: String = String()
        var tags: String = String()
    }
    
    let initialState: State
    
    init(_ date: Date) {
        self.initialState = State(date: date)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        
        case .popViewController:
            self.steps.accept(DiaryStep.popViewController)
            return Observable.empty()
            
        case let .writeDiary(data, tags):
            return Observable.just(Mutation.updateDiary(data, tags))
            
        case .saveDidary:
            let realm = try! Realm()
            
            let diary = RealmDiary().then {
                $0.date = self.currentState.date
                $0.data = self.currentState.data
                $0.tags = self.currentState.tags
            }
            
            do {
                try realm.write {
                    realm.add(diary)
                }
            } catch {
                print("이미 일기가 있어요")
            }
            
            self.steps.accept(DiaryStep.popViewController)
            return Observable.empty()
        }
        
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case let .updateDiary(data, tags):
            state.data = data
            state.tags = tags
        }
        
        return state
    }
    
}
