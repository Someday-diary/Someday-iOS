//
//  AppDelegate.swift
//  diary
//
//  Created by 김부성 on 2021/07/03.
//

import UIKit

import RxSwift
import RxFlow
import RxCocoa

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var coordinator: FlowCoordinator = .init()
    fileprivate let disposeBag = DisposeBag()
    
    lazy var appSerivces = {
        return AppServices()
    }()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .systemBackground
        self.window?.makeKeyAndVisible()
        
        guard let window = self.window else { return false }
        
        let appFlow = AppFlow(window: window, services: appSerivces)
        
        let appStepper = OneStepper(withSingleStep: DiaryStep.splashIsRequired)
        
        // Setup Rxflow
        self.coordinator.coordinate(flow: appFlow, with: appStepper)
        
        
        coordinator.rx.willNavigate.subscribe(onNext: { (flow, step) in
            print ("did navigate to flow=\(flow) and step=\(step)")
        }).disposed(by: self.disposeBag)
        
        coordinator.rx.didNavigate.subscribe(onNext: { (flow, step) in
            print ("did navigate to flow=\(flow) and step=\(step)")
        }).disposed(by: self.disposeBag)
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

