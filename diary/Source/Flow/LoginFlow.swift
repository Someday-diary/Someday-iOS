//
//  IntroFlow.swift
//  diary
//
//  Created by 김부성 on 2021/08/25.
//

import RxFlow

class LoginFlow: Flow {
    
    private let services: AppServices
    
    // MARK: - Properties
    var root: Presentable {
        return self.rootViewController
    }
    
    private lazy var rootViewController = UINavigationController().then {
        $0.navigationBar.setBackgroundImage(UIImage(), for: .default)
        $0.navigationBar.shadowImage = UIImage()
        $0.navigationBar.isTranslucent = true
    }
    
    // MARK: - Init
    init(_ services: AppServices) {
        self.services = services
    }
    
    deinit {
        print("deinit \(type(of: self)) : \(#function)")
    }
    
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? DiaryStep else { return .none }
        
        switch step {
        case .loginIsRequired:
            return self.navigateToLogin(authService: services.authService)
            
        case .registerIsRequired:
            return .none
            
        case .mainIsRequired:
            return .end(forwardToParentFlowWithStep: DiaryStep.mainIsRequired)
            
        case .dismiss:
            self.rootViewController.dismiss(animated: true, completion: nil)
            return .none
            
        default:
            return .none
        }
    }
    
}

extension LoginFlow {
    
    private func navigateToLogin(authService: AuthServiceType) -> FlowContributors {
        let reactor = LoginViewReactor(authService: authService)
        let viewController = LoginViewController(reactor: reactor)
        
        self.rootViewController.pushViewController(viewController, animated: false)
        
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: reactor))
    }
    
}
