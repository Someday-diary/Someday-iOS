//
//  WriteViewReactor.swift
//  diary
//
//  Created by 김부성 on 2021/09/04.
//

import Foundation

import ReactorKit
import RxRelay
import RealmSwift
import RxFlow

final class WriteViewReactor: Reactor, Stepper {
    
    var steps = PublishRelay<Step>()
    
    
    enum Action {
        case popViewController
        case saveDidary(String, String)
    }
    
    enum Mutation {
        
    }
    
    struct State {
        var date: Date
        var data: String
        var tags: String
    }
    
    let initialState: State
    
    init(date: Date, diary: RealmDiary?) {
        if diary != nil {
            self.initialState = State(date: date, data: diary!.data, tags: diary!.tags)
        } else {
            self.initialState = State(date: date, data: String(), tags: String())
        }
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        
        case .popViewController:
            self.steps.accept(DiaryStep.popViewController)
            return Observable.empty()
            
        case let .saveDidary(data, tags):
            let realm = try! Realm()
            
            let diary = RealmDiary().then {
                $0.date = self.currentState.date.realmString
                $0.data = data
                $0.tags = tags
            }
            
            do {
                try realm.write {
                    realm.add(diary, update: .modified)
                }
            } catch {
                print("이미 일기가 있어요")
            }
            
            self.steps.accept(DiaryStep.popViewController)
            return Observable.empty()
        }
        
    }
    
}
