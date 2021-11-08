//
//  SideMenuViewReactor.swift
//  diary
//
//  Created by 김부성 on 2021/08/28.
//

import Foundation

import ReactorKit
import RxCocoa
import RxFlow
import SwiftMessages
import Carte

final class SideMenuViewReactor: Reactor, Stepper {

    var steps = PublishRelay<Step>()
    
    enum Action {
        case dismiss
        case logout
        case setTheme
        case setAlarm
        case setLock
        case showInfo
        case userFeedBack
        case disappear
    }
    
    enum Mutation {
        
    }
    
    struct State {
        var date: Date
    }
    
    let initialState: State
    fileprivate let authService: AuthServiceType
    
    init(date: Date, authService: AuthServiceType) {
        self.initialState = State(date: date)
        self.authService = authService
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
            
        case .dismiss:
            self.steps.accept(DiaryStep.dismiss)
            self.steps.accept(DiaryStep.floatingPanelIsRequired(currentState.date))
            return Observable.empty()
            
        case .logout:
            return self.authService.logoutRequest()
                .map { result in
                    switch result {
                    case .success:
                        self.authService.logout()
                        self.steps.accept(DiaryStep.dismiss)
                        self.steps.accept(DiaryStep.splashIsRequired)
                    case let .error(error):
                        if error == NetworkError.alreadyLogout || error == NetworkError.unauthorized {
                            self.authService.logout()
                            self.steps.accept(DiaryStep.dismiss)
                            self.steps.accept(DiaryStep.splashIsRequired)
                        } else {
                            SwiftMessages.show(config: Message.diaryConfig, view: Message.faildView(error.message))
                        }
                    }
                }.asObservable().flatMap { _ in Observable.empty() }
            
        case .setTheme:
            self.steps.accept(DiaryStep.dismiss)
            self.steps.accept(DiaryStep.themeIsRequired)
            return Observable.empty()
            
        case .setAlarm:
            return Observable.empty()
            
        case .setLock:
            return Observable.empty()
            
        case .showInfo:
            return Observable.empty()
        
        case .userFeedBack:
            let email = "somedayteam2021@gmail.com".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let title = "오늘하루 유저 피드백".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let mailUrl = URL(string: "mailto:\(email)")!
            
            if UIApplication.shared.canOpenURL(mailUrl) {
                UIApplication.shared.open(mailUrl, options: [:])
            }
            
            return Observable.empty()
            
        case .disappear:
            return Observable.empty()
            
        }
    }
    
    
    
}
