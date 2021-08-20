//
//  App.swift
//  diary
//
//  Created by 김부성 on 2021/08/20.
//

import RxFlow

class AppFlow: Flow {
    
    private let window: UIWindow
    
    var root: Presentable {
        return self.window
    }
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? DiaryStep else { return .none }
        
        switch step {
        case .splashIsRequired:
            return .none
            
        case .introIsRequired:
            return .none
            
        case .mainIsRequired:
            return .none
            
        default:
            return .none
            
        }
    }
    
}

extension AppFlow {
//    private func navigateToSplash() -> FlowContributors {
//        return
//    }
}
