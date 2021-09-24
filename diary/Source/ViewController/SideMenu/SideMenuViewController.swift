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
        // Title
        static let titleTopRatio = 20.f
        static let titleBottomRatio = 20.f
        
        // Scroll View
        static let scrollViewSide = 16.f
        
        // Logout Button
        static let logoutButtonBottom = 30.f
    }
    
    fileprivate struct Font {
        static let titleFont = UIFont.systemFont(ofSize: 26, weight: .regular)
    }
    
    // MARK: - UI
    let titleLabel = UILabel().then {
        $0.text = "오늘 하루"
        $0.font = Font.titleFont
    }
    
    let scrollView = SideMenuScrollView()
    
    let dismissButton = UIBarButtonItem().then {
        $0.image = R.image.dismissButton()
        $0.tintColor = R.color.navigationButtonColor()
    }
    
    let logoutButton = LogoutButton()
    
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
        
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.logoutButton)
        self.view.addSubview(self.scrollView)
        self.navigationItem.rightBarButtonItem = dismissButton
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.titleLabel.snp.makeConstraints {
            $0.top.equalToSafeArea(self.view).offset(self.view.frame.height / Metric.titleTopRatio)
            $0.centerX.equalToSafeArea(self.view)
            $0.bottom.equalTo(self.scrollView.snp.top).offset(-self.view.frame.height / Metric.titleBottomRatio)
        }
        
        self.scrollView.snp.makeConstraints {
            $0.left.equalToSafeArea(self.view).offset(Metric.scrollViewSide)
            $0.right.equalToSafeArea(self.view).offset(-Metric.scrollViewSide)
            $0.bottom.equalTo(self.logoutButton.snp.top)
        }
        
        self.logoutButton.snp.makeConstraints {
            $0.bottom.equalToSafeArea(self.view).offset(-Metric.logoutButtonBottom)
            $0.right.equalToSafeArea(self.view).offset(-Metric.scrollViewSide)
            $0.width.equalTo(self.view.frame.width / 2)
        }
    }
    
    // MARK: - Configuring
    func bind(reactor: SideMenuViewReactor) {
        //input
        self.logoutButton.rx.tap.asObservable()
            .map { Reactor.Action.logout }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.dismissButton.rx.tap.asObservable()
            .map { Reactor.Action.dismiss }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        Observable.merge(
            scrollView.themeButton.rx.tap.map { Reactor.Action.setTheme },
            scrollView.alarmButton.rx.tap.map { Reactor.Action.setAlarm },
            scrollView.lockButton.rx.tap.map { Reactor.Action.setLock },
            scrollView.infoButton.rx.tap.map { Reactor.Action.showInfo },
            scrollView.feedbackButton.rx.tap.map { Reactor.Action.userFeedBack }
        ).asObservable()
        .bind(to: reactor.action)
        .disposed(by: disposeBag)
        
        self.rx.viewWillDisappear.asObservable()
            .map { _ in Reactor.Action.disappear }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }

}
