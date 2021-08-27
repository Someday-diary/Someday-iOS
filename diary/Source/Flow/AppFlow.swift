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
            return navigateToSplash()
            
        case .loginIsRequired:
            return navigateToLogin()
            
        case .mainIsRequired:
            return navigateToMain()
            
        default:
            return .none
            
        }
    }
    
}

extension AppFlow {
    
    private func navigateToSplash() -> FlowContributors {
        let reactor = SplashViewReactor()
        let viewController = SplashViewController(reactor: reactor)
        
        self.window.rootViewController = viewController
        
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: reactor))
    }
    
    private func navigateToLogin() -> FlowContributors {
        let loginFlow = LoginFlow()
        
        Flows.use(loginFlow, when: .created) { [unowned self] root in
            self.window.rootViewController = root
            
            UIView.transition(with: self.window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
        
        return .one(flowContributor: .contribute(withNextPresentable: loginFlow, withNextStepper: OneStepper(withSingleStep: DiaryStep.loginIsRequired)))
    }
    
    private func navigateToMain() -> FlowContributors {
        let mainFlow = MainFlow()
        
        Flows.use(mainFlow, when: .created) { [unowned self] root in
            self.window.rootViewController = root
            
            UIView.transition(with: self.window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
        
        return .one(flowContributor: .contribute(withNextPresentable: mainFlow, withNextStepper: OneStepper(withSingleStep: DiaryStep.mainIsRequired)))
    }
}
