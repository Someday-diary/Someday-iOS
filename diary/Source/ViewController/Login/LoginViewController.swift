//
//  LoginViewController.swift
//  diary
//
//  Created by 김부성 on 2021/08/24.
//

import UIKit

import Atributika
import ReactorKit
import RxKeyboard

class LoginViewController: BaseViewController, View {
    typealias Reactor = LoginViewReactor
    
    // MARK: - Constants
    fileprivate struct Metric {
        
        // Image
        static let imageRatio = (50 / 70).f
        static let imageHeight = 70.f
        static let imageWidth = 50.f
        static let imageTop = 60.f
        
        // TextField
        static let textFieldSide = 30.f
        static let textFieldHeight = 50.f
        
        // Login
        static let loginHeight = 40.f
        static let loginSide = 30.f
        static let loginBottom = 10.f
        
        // Register
        static let registerBottom = 70.f
        static let registerHeight = 20.f
        static let registerKeyboard = 10.f
    }
    
    fileprivate struct Font {
        // Login Button
        static let loginFont = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        // Register Button
        static let registerHighlight = Style("h")
            .font(.systemFont(ofSize: 14, weight: .semibold))
            .underlineStyle(.single)
        static let registerAll = Style.font(.systemFont(ofSize: 14)).foregroundColor(.black)
    }
    
    // MARK: - UI
    let loginImageView = UIImageView().then {
        $0.theme.image = themed { $0.mainIllustration }
    }
    
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
        $0.titleLabel?.font = Font.loginFont
    }
    
    let registerButton = UIButton(type: .system).then {
        $0.backgroundColor = .clear
    }
    
    let socialLogin = UIImageView().then {
        $0.image = R.image.socialLoginHolderImage()
    }
    
    // MARK: - Initializing
    init(reactor: Reactor) {
        super.init()
        
        defer { self.reactor = reactor }
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
        self.view.addSubview(self.registerButton)
        self.view.addSubview(self.socialLogin)
        
        // Bind
        self.UIBind()
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.loginImageView.snp.makeConstraints {
            $0.height.equalTo(Metric.imageHeight)
            $0.width.equalTo(Metric.imageWidth)
            $0.centerX.equalToSafeArea(self.view)
        }
        
        self.idTextField.snp.makeConstraints {
            $0.left.equalToSafeArea(self.view).offset(Metric.textFieldSide)
            $0.right.equalToSafeArea(self.view).offset(-Metric.textFieldSide)
            $0.height.equalTo(Metric.textFieldHeight)
        }
        
        self.passwordTextField.snp.makeConstraints {
            $0.left.equalToSafeArea(self.view).offset(Metric.textFieldSide)
            $0.right.equalToSafeArea(self.view).offset(-Metric.textFieldSide)
            $0.top.equalTo(self.idTextField.snp.bottom)
            $0.height.equalTo(Metric.textFieldHeight)
        }
        
        self.socialLogin.snp.makeConstraints {
            $0.centerX.equalToSafeArea(self.view)
            $0.width.equalTo(125)
            $0.height.equalTo(75)
            $0.bottom.equalTo(self.loginButton.snp.top).offset(-25)
        }
        
        self.loginButton.snp.makeConstraints {
            $0.left.equalToSafeArea(self.view).offset(Metric.loginSide)
            $0.right.equalToSafeArea(self.view).offset(-Metric.loginSide)
            $0.height.equalTo(Metric.loginHeight)
            $0.bottom.equalTo(self.registerButton.snp.top).offset(-Metric.loginBottom)
        }
        
        self.registerButton.snp.makeConstraints {
            $0.centerX.equalToSafeArea(self.view)
            $0.height.equalTo(Metric.registerHeight)
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
    }
    
}

extension LoginViewController {
    fileprivate func UIBind() {
        RxKeyboard.instance.visibleHeight
            .distinctUntilChanged()
            .drive(onNext: { [weak self] height in
                guard let `self` = self else { return }
                
                // update
                self.loginImageView.snp.updateConstraints {
                    $0.top.equalToSafeArea(self.view).offset(height == 0 ? self.view.frame.height/20 : -25)
                }
                
                self.idTextField.snp.updateConstraints {
                    $0.top.equalTo(self.loginImageView.snp.bottom).offset(height == 0 ? self.view.frame.height / 10 : ((self.view.frame.height - height) / 12).iPhoneSETop )
                }
                
                self.registerButton.snp.updateConstraints {
                    $0.bottom.equalToSafeArea(self.view).offset(height == 0 ? -self.view.frame.height / 20 : -height-Metric.registerKeyboard)
                }
                
                // animation
                UIView.animate(withDuration: 0.1) {
                    self.socialLogin.alpha = height == 0 ? 1 : 0
                    self.view.layoutIfNeeded()
                }
            })
            .disposed(by: disposeBag)
        
        themed { $0.thirdColor }.asObservable()
            .distinctUntilChanged()
            .subscribe (onNext: { [weak self] color in
                guard let `self` = self else { return }
                let text = "아직 회원이 아니신가요? <h>회원가입하기</h>".style(tags: Font.registerHighlight.foregroundColor(color)).styleAll(Font.registerAll).attributedString
                self.registerButton.setAttributedTitle(text, for: .normal)
            })
            .disposed(by: disposeBag)
    }
}
