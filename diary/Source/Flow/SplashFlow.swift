//
//  SplashFlow.swift
//  diary
//
//  Created by 김부성 on 2021/11/11.
//

import RxFlow

class SplashFlow: Flow {
    
    private let services: AppServices
    
    var root: Presentable {
        return self.rootViewController
    }
    
    let navigationAppearance = UINavigationBarAppearance().then {
        $0.configureWithTransparentBackground()
    }
    
    private lazy var rootViewController = UINavigationController().then {
        $0.navigationBar.standardAppearance = navigationAppearance
        $0.navigationBar.isHidden = true
        $0.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    init(_ services: AppServices) {
        self.services = services
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? DiaryStep else { return .none }
        
        switch step {
            
        case .splashIsRequired:
            return navigateToSplash()
            
        case let .passcodeIsRequired(type):
            return navigateToPasscode(type: type)
            
        case .mainIsRequired:
            return .end(forwardToParentFlowWithStep: DiaryStep.mainIsRequired)
            
        case .loginIsRequired:
            return .end(forwardToParentFlowWithStep: DiaryStep.loginIsRequired)
            
        case .dismiss:
            self.rootViewController.dismiss(animated: true, completion: nil)
            return .none
            
        case .popViewController:
            self.rootViewController.popViewController(animated: true)
            return .none
            
        default:
            return .none
        }
    }
    
    
}

extension SplashFlow {
    
    private func navigateToSplash() -> FlowContributors {
        let reactor = SplashViewReactor(authService: services.authService)
        let viewController = SplashViewController(reactor: reactor)
        
        self.rootViewController.pushViewController(viewController, animated: false)
        
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: reactor))
    }
    
    private func navigateToPasscode(type: PasscodeType) -> FlowContributors {
        let reactor = PasscodeViewReactor(type: type, authService: services.authService)
        let viewController = PasscodeViewController(reactor: reactor)
        
        self.rootViewController.pushViewController(viewController, animated: false)
        
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: reactor))
    }
    
}
