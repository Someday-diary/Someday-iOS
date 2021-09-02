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
    let listButton = DiarySideMenuListButton().then {
        $0.icon.image = R.image.themeIcon()
        $0.button.setTitle("테마 설정", for: .normal)
        $0.button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
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
        
        self.view.addSubview(self.listButton)
        self.navigationItem.rightBarButtonItem = dismissButton
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.listButton.snp.makeConstraints {
            $0.centerY.equalToSafeArea(self.view)
            $0.left.equalToSafeArea(self.view).offset(20)
            $0.right.equalToSafeArea(self.view).offset(-20)
            $0.height.equalTo(35)
        }
    }
    
    // MARK: - Configuring
    func bind(reactor: SideMenuViewReactor) {
        //input
        self.listButton.button.rx.tap.asObservable()
            .subscribe(onNext: {
                print("tapped!")
            })
            .disposed(by: disposeBag)
        
        self.dismissButton.rx.tap.asObservable()
            .map { Reactor.Action.dismiss }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }

}
