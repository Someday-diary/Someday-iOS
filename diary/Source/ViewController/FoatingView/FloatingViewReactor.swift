//
//  FloatingViewReactor.swift
//  diary
//
//  Created by 김부성 on 2021/09/10.
//

import Foundation

import ReactorKit
import RxRelay
import RxFlow
import SwiftMessages

final class FloatingViewReactor: Reactor, Stepper {
    var steps = PublishRelay<Step>()
    
    let initialState: State
    
    enum Action {
        case write
        case edit
        case update
        case delete
        case cancel
    }
    
    enum Mutation {
        case updateDate(Date)
        case updateDiary(Diary?)
        case setLoading(Bool)
    }
    
    struct State {
        var selectedDay: Date
        var currentDiary: Diary?
        var diaryData: String = String()
        var diaryTags: String = String()
        var createState: Bool = true
        var isLoading: Bool = false
    }
    
    let userService: UserServiceType
    let diaryService: DiaryServiceType
    
    init(date: Date, userService: UserServiceType, diaryService: DiaryServiceType) {
        self.initialState = State(selectedDay: date)
        
        self.userService = userService
        self.diaryService = diaryService
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .update:
            let currentDay = currentState.selectedDay
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                
                diaryService.getDayDiary(currentDay.year, currentDay.month, currentDay.date).asObservable()
                    .map { result in
                        switch result {
                        case let .success(result):
                            return Mutation.updateDiary(result.post?.toDiary)
                        case let .error(error):
                            print(error)
                            return Mutation.updateDiary(nil)
                        }
                    },
                
                Observable.just(Mutation.setLoading(false))
            ])
            
        case .write:
            self.steps.accept(DiaryStep.writeIsRequired(self.currentState.selectedDay, nil))
            return Observable.empty()
            
        case .edit:
            self.steps.accept(DiaryStep.writeIsRequired(self.currentState.selectedDay, self.currentState.currentDiary))
            return Observable.empty()
            
        case .delete:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                
                diaryService.deleteDiary(self.currentState.currentDiary?.id ?? "").asObservable()
                    .map { result in
                        switch result {
                        case .success:
                            _ = Observable.just(self.userService.deleteDiary())
                            return Mutation.updateDiary(nil)
                        case let .error(error):
                            SwiftMessages.show(config: Message.diaryConfig, view: Message.faildView(error.message))
                            return Mutation.updateDiary(self.currentState.currentDiary)
                        }
                    },
                
                Observable.just(Mutation.setLoading(false))
            ])
            
        case .cancel:
            return Observable.empty()
        }
    }
    
    // Global State
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let eventMutation = userService.event.flatMap { [weak self] event -> Observable<Mutation> in
            guard let self = self else { return Observable.empty() }
            
            switch event {
            
            case let .updateDate(newDay):
                return Observable.concat([
                    Observable.just(Mutation.updateDate(newDay)),
                                        
                    Observable.just(Mutation.setLoading(true)),
                    
                    self.diaryService.getDayDiary(newDay.year, newDay.month, newDay.date).asObservable()
                        .map { result in
                            switch result {
                            case let .success(result):
                                return Mutation.updateDiary(result.post?.toDiary)
                            case let .error(error):
                                print(error)
                                return Mutation.updateDiary(nil)
                            }
                        },
                    
                    Observable.just(Mutation.setLoading(false))
                ])
                
            default:
                return Observable<Mutation>.empty()
            }
        }
        
        return Observable.merge(mutation, eventMutation)
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        
        case let .updateDiary(diary):
            if diary == nil {
                state.diaryData = "Diary dosen't exist!\nHow about write diary?".localized
                state.diaryTags = "Add Tags".localized
                state.createState = true
                state.currentDiary = nil
            } else {
                state.diaryData = diary!.data
                state.diaryTags = diary!.tags
                state.createState = false
                state.currentDiary = diary
            }
        
        case let .updateDate(newDay):
            state.selectedDay = newDay
            
        case let .setLoading(isLoading):
            state.isLoading = isLoading
            
        }
        
        return state
    }
}
