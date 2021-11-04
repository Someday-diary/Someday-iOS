//
//  HomeFlow.swift
//  diary
//
//  Created by 김부성 on 2021/08/27.
//

import UIKit
import RxFlow
import FloatingPanel
import SideMenu

class HomeFlow: Flow {
    
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
    
    private let shadow = SurfaceAppearance.Shadow().then {
        $0.color = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1)
    }

    private lazy var fpc = FloatingPanelController().then {
        $0.layout = CustomFloatingPanelLayout()
        $0.surfaceView.appearance.cornerRadius = 25
        $0.surfaceView.appearance.shadows = [self.shadow]
        $0.delegate = self
    }
    
    init(_ services: AppServices) {
        self.services = services
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? DiaryStep else { return .none }
        
        switch step {
        case .mainIsRequired:
            return navigateToMain()
            
        case let .floatingPanelIsRequired(date):
            return presentFloatingPanel(date: date)
            
        case let .sideMenuIsRequired(date):
            return navigateToSideMenu(date: date)
            
        case let .writeIsRequired(date, diary):
            return navigateToWrite(date, diary)
            
        case .searchIsRequired:
            return navigateToSearch()
            
        case .themeIsRequired:
            return navigateToTheme()
            
        case .splashIsRequired:
            return .end(forwardToParentFlowWithStep: DiaryStep.splashIsRequired)
            
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

extension HomeFlow: FloatingPanelControllerDelegate {
    
    private func navigateToMain() -> FlowContributors {
        let reactor = MainViewReactor(userService: services.userService, diaryService: services.diaryService)
        let viewController = MainViewController(reactor: reactor)
        
        self.rootViewController.pushViewController(viewController, animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: reactor))
    }
    
    private func presentFloatingPanel(date: Date) -> FlowContributors {
        let reactor = FloatingViewReactor(date: date, userService: services.userService, diaryService: services.diaryService)
        fpc.set(contentViewController: FloatingViewController(reactor: reactor))
        
        self.rootViewController.present(fpc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: fpc, withNextStepper: reactor))
    }
    
    private func navigateToWrite(_ date: Date, _ diary: Diary?) -> FlowContributors {
        let reactor = WriteViewReactor(date: date, diary: diary, diaryService: services.diaryService)
        let viewController = WriteViewController(reactor: reactor)
        
        self.rootViewController.dismiss(animated: true)
        self.rootViewController.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: reactor))
    }
    
    private func navigateToSearch() -> FlowContributors {
        let reactor = SearchViewReactor()
        let viewController = SearchViewController(reactor: reactor)
        
        self.rootViewController.dismiss(animated: true)
        self.rootViewController.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: reactor))
    }
    
    private func navigateToTheme() -> FlowContributors {
        let reactor = ThemeViewReactor()
        let viewController = ThemeViewController(reactor: reactor)
        
        self.rootViewController.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: reactor))
    }
    
    private func navigateToSideMenu(date: Date) -> FlowContributors {
        let reactor = SideMenuViewReactor(date: date, authService: services.authService)
        let viewController = SideMenuViewController(reactor: reactor)
        let sideMenuNavController = SideMenuNavigationController(rootViewController: viewController).then {
            $0.leftSide = true
            $0.presentationStyle = .menuSlideIn
            $0.presentationStyle.presentingEndAlpha = 0.6
            $0.menuWidth = 280
            $0.navigationBar.standardAppearance = navigationAppearance
            $0.enableTapToDismissGesture = false
            $0.enableSwipeToDismissGesture = false
        }
        
        self.rootViewController.dismiss(animated: true)
        self.rootViewController.present(sideMenuNavController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: sideMenuNavController, withNextStepper: reactor))
    }
    
    func floatingPanelDidChangeState(_ fpc: FloatingPanelController) {
        UIView.animate(withDuration: 0.5) {
            fpc.surfaceView.theme.backgroundColor = fpc.state == .tip ? themed { $0.subColor } : themed { $0.backgroundColor }
            fpc.surfaceView.layoutIfNeeded()
        }
    }
}
