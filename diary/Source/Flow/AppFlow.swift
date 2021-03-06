//
//  AppFkow.swift
//  diary
//
//  Created by 김부성 on 2021/08/20.
//

import RxFlow

class AppFlow: Flow {
    
    private let window: UIWindow
    private let services: AppServices
    
    var root: Presentable {
        return self.window
    }
    
    init(window: UIWindow, services: AppServices) {
        self.window = window
        self.services = services
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
            
        case let .passcodeIsRequired(type):
            return navigateToPasscode(type: type)
        default:
            return .none
            
        }
    }
    
}

extension AppFlow {
    
    private func navigateToSplash() -> FlowContributors {
        let splashFlow = SplashFlow(services)
        
        Flows.use(splashFlow, when: .created) { [unowned self] root in
            self.window.rootViewController = root
            
            UIView.transition(with: self.window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
            
        }
        
        return .one(flowContributor: .contribute(withNextPresentable: splashFlow, withNextStepper: OneStepper(withSingleStep: DiaryStep.splashIsRequired)));
    }
    
    private func navigateToLogin() -> FlowContributors {
        let loginFlow = LoginFlow(services)
        
        Flows.use(loginFlow, when: .created) { [unowned self] root in
            self.window.rootViewController = root
            
            UIView.transition(with: self.window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
        
        return .one(flowContributor: .contribute(withNextPresentable: loginFlow, withNextStepper: OneStepper(withSingleStep: DiaryStep.loginIsRequired)))
    }
    
    private func navigateToPasscode(type: PasscodeType) -> FlowContributors {
        let homeFlow = HomeFlow(services)
        
        Flows.use(homeFlow, when: .created) { [unowned self] root in
            self.window.rootViewController = root
            
            UIView.transition(with: self.window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
        
        return .one(flowContributor: .contribute(withNextPresentable: homeFlow, withNextStepper: OneStepper(withSingleStep: DiaryStep.passcodeIsRequired(type))))
    }
    
    private func navigateToMain() -> FlowContributors {
        let homeFlow = HomeFlow(services)
        
        Flows.use(homeFlow, when: .created) { [unowned self] root in
            self.window.rootViewController = root
            
            UIView.transition(with: self.window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
        
        return .one(flowContributor: .contribute(withNextPresentable: homeFlow, withNextStepper: OneStepper(withSingleStep: DiaryStep.mainIsRequired)))
    }
}
