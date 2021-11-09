//
//  PassCodeViewController.swift
//  diary
//
//  Created by 김부성 on 2021/11/09.
//

import UIKit
import RxCocoa
import ReactorKit
import RxFlow

final class PasscodeViewController: BaseViewController, View {
    
    typealias Reactor = PasscodeViewReactor
    
    // MARK: Constants
    struct Metric {
        static let descriptionLabelTop = 100.f
        static let passwordFieldTop = 50.f
        static let passwordFieldWidth = 150.f
        static let passwordFieldHeight = 50.f
        static let passwordPadHeight = 300.f
    }
    
    struct Font {
        static let descriptionLabel = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
    // MARK: - UI
    let descriptionLabel = UILabel().then {
        $0.font = Font.descriptionLabel
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.textColor = R.color.passcodeTextColor()
    }
    
    let passwordField = SecureTextEntry()
    
    let passwordPad = DiaryNumberPad(type: .normal)
    
    // MARK: - Initializing
    init(
        reactor: Reactor
    ) {
        defer { self.reactor = reactor }
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = R.color.passcodeBackground()
        self.view.addSubview(self.descriptionLabel)
        self.view.addSubview(self.passwordField)
        self.view.addSubview(self.passwordPad)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.descriptionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSafeArea(self.view).offset(Metric.descriptionLabelTop)
        }
        
        self.passwordField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Metric.passwordFieldWidth)
            $0.height.equalTo(Metric.passwordFieldHeight)
            $0.top.equalTo(self.descriptionLabel.snp.bottom)
                .offset(Metric.passwordFieldTop)
        }
        
        self.passwordPad.snp.makeConstraints {
            $0.left.equalToSafeArea(self.view).offset(20)
            $0.right.equalToSafeArea(self.view).offset(-20)
            $0.bottom.equalToSafeArea(self.view)
            $0.height.equalTo(Metric.passwordPadHeight)
        }
    }
    
    // MARK: - Configuring
    func bind(reactor: Reactor) {
        // MARK: - input
        self.passwordPad.currentState
            .bind(to: self.passwordField.subject)
            .disposed(by: disposeBag)
        
        self.passwordField.currentText
            .map { Reactor.Action.callBack($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.message }.asObservable()
            .distinctUntilChanged()
            .bind(to: descriptionLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
