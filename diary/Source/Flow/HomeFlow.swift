//
//  HomeFlow.swift
//  diary
//
//  Created by 김부성 on 2021/08/27.
//

import RxFlow
import SideMenu

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
            
        case .sideMenuIsRequired:
            return navigateToSideMenu()
            
        case .dismiss:
            self.rootViewController.dismiss(animated: true, completion: nil)
            return .none
            
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
    
    private func navigateToSideMenu() -> FlowContributors {
        let reactor = SideMenuViewReactor()
        let viewController = SideMenuViewController(reactor: reactor)
        let sideMenuNavController = SideMenuNavigationController(rootViewController: viewController).then {
            $0.leftSide = true
            $0.presentationStyle = .menuSlideIn
            $0.presentationStyle.presentingEndAlpha = 0.5
        }
        
        self.rootViewController.present(sideMenuNavController, animated: true, completion: nil)
        return .one(flowContributor: .contribute(withNextPresentable: sideMenuNavController, withNextStepper: reactor))
    }
}
