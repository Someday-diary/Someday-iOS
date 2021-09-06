//
//  DiaryStep.swift
//  diary
//
//  Created by 김부성 on 2021/08/20.
//

import RxFlow

enum DiaryStep: Step {
    case dismiss
    case popViewController
    
    // MARK: - Splash
    case splashIsRequired
    case loginIsRequired
    case mainIsRequired
    
    // MARK: - Login
    case registerIsRequired
    
    // MARK: - Home
    case sideMenuIsRequired
    case writeIsRequired(Date)
}
