//
//  HomeFlow.swift
//  diary
//
//  Created by 김부성 on 2021/08/27.
//

import UIKit
import RxFlow
import SideMenu

class MainFlow: Flow {
    
    private let services: AppServices
    
    var root: Presentable {
        return self.rootViewController
    }
    
    let navigationAppearance = UINavigationBarAppearance().then {
        $0.configureWithTransparentBackground()
    }
    
    private lazy var rootViewController = UINavigationController().then {
        $0.navigationBar.standardAppearance = navigationAppearance
    }
    
    init(_ services: AppServices) {
        self.services = services
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? DiaryStep else { return .none }
        
        switch step {
        case .mainIsRequired:
            return navigateToMain()
            
        case .sideMenuIsRequired:
            return navigateToSideMenu()
            
        case .splashIsRequired:
            return .end(forwardToParentFlowWithStep: DiaryStep.splashIsRequired)
            
        case .writeIsRequired:
            return navigateToWrite()
            
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
    
    private func navigateToWrite() -> FlowContributors {
        let reactor = WriteViewReactor()
        let viewController = WriteViewController(reactor: reactor)
        
        self.rootViewController.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: reactor))
    }
    
    private func navigateToSideMenu() -> FlowContributors {
        let reactor = SideMenuViewReactor()
        let viewController = SideMenuViewController(reactor: reactor)
        let sideMenuNavController = SideMenuNavigationController(rootViewController: viewController).then {
            $0.leftSide = true
            $0.presentationStyle = .menuSlideIn
            $0.presentationStyle.presentingEndAlpha = 0.6
            $0.menuWidth = 280
            $0.navigationBar.standardAppearance = navigationAppearance
        }
        
        self.rootViewController.present(sideMenuNavController, animated: true, completion: nil)
        return .one(flowContributor: .contribute(withNextPresentable: sideMenuNavController, withNextStepper: reactor))
    }
}
