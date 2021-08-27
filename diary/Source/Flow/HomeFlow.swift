//
//  HomeFlow.swift
//  diary
//
//  Created by 김부성 on 2021/08/27.
//

import RxFlow

class MainFlow: Flow {
    
    private lazy var rootViewController = UINavigationController()
    
    var root: Presentable {
        return self.rootViewController
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? DiaryStep else { return .none }
        
        switch step {
        case .mainIsRequired:
            return navigateToMain()
        default:
            return .none
        }
    }
    
    
}

extension MainFlow {
    
    private func navigateToMain() -> FlowContributors {
        let reactor = MainViewReactor()
        let viewController = MainViewController(reactor: reactor)
        
        self.rootViewController.pushViewController(viewController, animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: reactor))
    }
    
}
