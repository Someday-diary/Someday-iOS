//
//  SideMenuViewController.swift
//  diary
//
//  Created by 김부성 on 2021/08/28.
//

import UIKit
import ReactorKit
import RxViewController

final class SideMenuViewController: BaseViewController, View {
    
    typealias Reactor = SideMenuViewReactor
    
    // MARK: - Constants
    fileprivate struct Metric {
        static let themeButtonSize = 30.f
    }
    
    // MARK: - UI
    let blueButton = DiaryThemeButton().then {
        $0.backgroundColor = R.color.blueThemeMainColor()
    }
    
    let greenButton = DiaryThemeButton().then {
        $0.backgroundColor = R.color.greenThemeMainColor()
    }
    
    let dismissButton = UIBarButtonItem().then {
        $0.image = R.image.dismissButton()
        $0.tintColor = R.color.drawerDismissButtonColor()
    }
    // MARK: - Initializing
    init(reactor: Reactor) {
        super.init()
        
        defer {
            self.reactor = reactor
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.view.addSubview(blueButton)
        self.view.addSubview(greenButton)
        self.navigationItem.rightBarButtonItem = dismissButton
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.blueButton.snp.makeConstraints {
            $0.centerY.equalToSafeArea(self.view)
            $0.left.equalTo(self.view.safeAreaLayoutGuide.snp.centerX).offset(25)
            $0.height.equalTo(Metric.themeButtonSize)
            $0.width.equalTo(Metric.themeButtonSize)
        }
        
        self.greenButton.snp.makeConstraints {
            $0.centerY.equalToSafeArea(self.view)
            $0.right.equalTo(self.view.safeAreaLayoutGuide.snp.centerX).offset(-25)
            $0.height.equalTo(Metric.themeButtonSize)
            $0.width.equalTo(Metric.themeButtonSize)
        }
    }
    
    // MARK: - Configuring
    func bind(reactor: SideMenuViewReactor) {
        //input
        self.blueButton.rx.tap.asObservable()
            .subscribe(onNext: { _ in
                themeService.switch(.blue)
                UIApplication.shared.windows.forEach { window in
                    window.overrideUserInterfaceStyle = .light
                }
            })
            .disposed(by: disposeBag)
        
        self.greenButton.rx.tap.asObservable()
            .subscribe(onNext: { _ in
                themeService.switch(.green)
                UIApplication.shared.windows.forEach { window in
                    window.overrideUserInterfaceStyle = .dark
                }
            })
            .disposed(by: disposeBag)
        
        self.dismissButton.rx.tap.asObservable()
            .map { Reactor.Action.dismiss }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }

}
