//
//  AppDelegate.swift
//  diary
//
//  Created by 김부성 on 2021/07/03.
//

import UIKit

import RxSwift
import RxCocoa
import RxFlow
import RxTheme
import RxViewController

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
        
        switch UserDefaults.standard.integer(forKey: "Appearance") {
            
        case 0:
            self.changeTheme(themeVal: "system")
            
        case 1:
            self.changeTheme(themeVal: "light")
            
        case 2:
            self.changeTheme(themeVal: "dark")
            
        default:
            self.changeTheme(themeVal: "system")
        }
        
        switch UserDefaults.standard.integer(forKey: "Theme") {
            
        case 0:
            themeService.switch(ThemeType.green)
            
        case 1:
            themeService.switch(ThemeType.blue)
            
        default:
            themeService.switch(ThemeType.green)
        }
        
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

    func applicationWillResignActive(_ application: UIApplication) {
        self.window?.endEditing(true)
    }
    
    func changeTheme(themeVal: String) {
      if #available(iOS 13.0, *) {
         switch themeVal {
         case "dark":
             window?.overrideUserInterfaceStyle = .dark
             
         case "light":
             window?.overrideUserInterfaceStyle = .light
             
         default:
             window?.overrideUserInterfaceStyle = .unspecified
         }
      }
    }

}

