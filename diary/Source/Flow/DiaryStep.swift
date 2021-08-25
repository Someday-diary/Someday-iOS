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
    
    //MARK: - Splash
    case splashIsRequired
    case mainIsRequired
    
    //MARK: - Intro
    case loginIsRequired
    case registerIsRequired
    
}
