//
//  AppStepper.swift
//  diary
//
//  Created by 김부성 on 2021/08/25.
//

import Foundation

import RxFlow
import RxRelay


struct AppSteppeer: Stepper {
    var steps: PublishRelay<Step> = .init()
    
    var initialStep: Step {
        return DiaryStep.splashIsRequired
    }
}
