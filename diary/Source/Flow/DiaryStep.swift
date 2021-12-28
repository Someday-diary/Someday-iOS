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
    case popToRootViewController
    
    // MARK: - Splash
    case splashIsRequired
    case loginIsRequired
    case mainIsRequired
    
    // MARK: - Login
    case registerIsRequired
    case passwordIsRequired(String)
    
    // MARK: - Home
    case sideMenuIsRequired(Date)
    case writeIsRequired(Date, Diary?)
    case floatingPanelIsRequired(Date)
    case themeIsRequired
    case lockIsRequired
    case feedbackIsRequired
    case searchIsRequired(String?)
    case passcodeIsRequired(PasscodeType)
}
