//
//  WriteViewReactor.swift
//  diary
//
//  Created by 김부성 on 2021/09/04.
//

import Foundation

import ReactorKit
import SwiftMessages
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
        var id: String
        var isEdit: Bool = false
        var isLoading: Bool = false
    }
    
    let initialState: State
    let diaryService: DiaryServiceType
    
    init(date: Date, diary: Diary?, diaryService: DiaryServiceType) {
        self.diaryService = diaryService
        
        if let diary = diary {
            self.initialState = State(date: date, data: diary.data, tags: diary.tags, id: diary.id, isEdit: true)
        } else {
            self.initialState = State(date: date, data: String(), tags: String(), id: UUID().uuidString, isEdit: false)
        }
        
        
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        
        case .popViewController:
            self.steps.accept(DiaryStep.popViewController)
            return Observable.empty()
            
        case let .saveDidary(data, tags):
            
            if data.isEmpty || tags.isEmpty {
                SwiftMessages.show(config: Message.diaryConfig, view: Message.faildView("일기에 빈칸이 존재하는 것 같아요!"))
                return Observable.empty()
            } else {
                if self.currentState.isEdit {
                    return Observable.concat([
                        Observable.just(Mutation.setLoading(true)),
                        
                        self.diaryService.updateDiary(Diary(date: self.currentState.date.dataString, data: data, tags: tags, id: self.currentState.id)).asObservable()
                            .map { result in
                                switch result {
                                case .success:
                                    print("일기 저장 성공")
                                    self.steps.accept(DiaryStep.popViewController)
                                    
                                case let .error(error):
                                    SwiftMessages.show(config: Message.diaryConfig, view: Message.faildView(error.message))
                                }
                            }.flatMap { _ in Observable.empty() },
                        
                        Observable.just(Mutation.setLoading(false))
                    ])
                    
                } else {
                    return Observable.concat([
                        Observable.just(Mutation.setLoading(true)),
                        
                        self.diaryService.createDiary(Diary(date: self.currentState.date.dataString, data: data, tags: tags, id: self.currentState.id)).asObservable()
                            .map { result in
                                switch result {
                                case .success:
                                    print("일기 저장 성공")
                                    self.steps.accept(DiaryStep.popViewController)
                                    
                                case let .error(error):
                                    SwiftMessages.show(config: Message.diaryConfig, view: Message.faildView(error.message))
                                }
                            }.flatMap { _ in Observable.empty() },
                        
                        Observable.just(Mutation.setLoading(false))
                    ])
                }
            }
            
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
