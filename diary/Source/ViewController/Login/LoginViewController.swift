//
//  LoginViewController.swift
//  diary
//
//  Created by 김부성 on 2021/08/24.
//

import UIKit
import ReactorKit
import RxKeyboard

class LoginViewController: BaseViewController, View {
    typealias Reactor = LoginViewReactor
    
    // MARK: - Constants
    fileprivate struct Metric {
        // TitleLabel
        static let titleLabelTop = 100.f
        
        // TextField
        static let textFieldSide = 50.f
        static let textFieldHeight = 60.f
        
        // Button
        static let buttonTop = 40.f
        static let buttonHeight = 40.f
        static let buttonSide = 44.f
        
        // Image
        static let imageHeight = 70.f
        static let imageWidth = 50.f
        static let imageTop = 60.f
    }
    
    fileprivate struct Font {
        static var titleFont = UIFont.systemFont(ofSize: 32, weight: .semibold)
        static var buttonFont = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    
    // MARK: - UI
    let idTextField = DiaryTextField().then {
        $0.textField.placeholder = "ID"
        $0.textField.keyboardType = .emailAddress
    }
    
    let passwordTextField = DiaryTextField().then {
        $0.textField.placeholder = "Password"
        $0.textField.keyboardType = .default
        $0.textField.isSecureTextEntry = true
    }
    
    let loginButton = DiaryButton(type: .system).then {
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = Font.buttonFont
    }
    
    let loginImageView = UIImageView().then {
        $0.theme.image = themed { $0.mainIllustration }
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
        
        self.view.addSubview(self.idTextField)
        self.view.addSubview(self.passwordTextField)
        self.view.addSubview(self.loginButton)
        self.view.addSubview(self.loginImageView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.loginImageView.snp.makeConstraints {
            $0.height.equalTo(Metric.imageHeight)
            $0.width.equalTo(Metric.imageWidth)
            $0.top.equalToSafeArea(self.view).offset(Metric.imageTop)
            $0.centerX.equalToSafeArea(self.view)
        }
        
        self.idTextField.snp.makeConstraints {
            $0.left.equalToSafeArea(self.view).offset(Metric.textFieldSide)
            $0.right.equalToSafeArea(self.view).offset(-Metric.textFieldSide)
            $0.bottom.equalTo(self.loginImageView.snp.bottom).offset(self.view.frame.height / 5.5)
            $0.height.equalTo(Metric.textFieldHeight)
        }
        
        self.passwordTextField.snp.makeConstraints {
            $0.left.equalToSafeArea(self.view).offset(Metric.textFieldSide)
            $0.right.equalToSafeArea(self.view).offset(-Metric.textFieldSide)
            $0.top.equalTo(self.idTextField.snp.bottom)
            $0.height.equalTo(Metric.textFieldHeight)
        }
        
        self.loginButton.snp.makeConstraints {
            $0.top.equalTo(self.passwordTextField.snp.bottom).offset(Metric.buttonTop)
            $0.left.equalToSafeArea(self.view).offset(Metric.buttonSide)
            $0.right.equalToSafeArea(self.view).offset(-Metric.buttonSide)
            $0.height.equalTo(Metric.buttonHeight)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    // MARK: - Configuring
    
    func bind(reactor: LoginViewReactor) {
        
        // Input
        Observable.combineLatest(
            idTextField.textField.rx.text.orEmpty,
            passwordTextField.textField.rx.text.orEmpty
        )
        .observeOn(MainScheduler.asyncInstance)
        .map { Reactor.Action.updateTextField([$0, $1]) }
        .bind(to: reactor.action)
        .disposed(by: disposeBag)
        
        loginButton.rx.tap.asObservable()
            .map { Reactor.Action.login }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // Output
        let idValidation = reactor.state.map { $0.idValidation }.distinctUntilChanged()
        let passwordValidation = reactor.state.map { $0.passwordValidation }.distinctUntilChanged()
        
        Observable.combineLatest(
            idValidation.map { $0 == .correct },
            passwordValidation.map { $0 == .correct }
        ) { $0 && $1 }
        .bind(to: loginButton.rx.isEnabled)
        .disposed(by: disposeBag)
        
        reactor.state.map { $0.idValidation }
            .distinctUntilChanged()
            .bind(to: self.idTextField.rx.animated.fade(duration: 0.3).error)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.passwordValidation }
            .distinctUntilChanged()
            .bind(to: self.passwordTextField.rx.animated.fade(duration: 0.3).error)
            .disposed(by: disposeBag)
        
        // View
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [weak self] height in
                guard let `self` = self else { return }
                self.view.frame.origin.y = 0 - height / 2.5
            })
            .disposed(by: disposeBag)
    }
    
}
