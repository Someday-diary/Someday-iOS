//
//  LoginViewController.swift
//  diary
//
//  Created by 김부성 on 2021/08/24.
//

import UIKit
import ReactorKit

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
        static let imageHeight = 173.f
        static let imageWidth = 242.f
        static let imageLeft = 33.f
    }
    
    fileprivate struct Font {
        static var titleFont = UIFont.systemFont(ofSize: 32, weight: .semibold)
    }
    
    // MARK: - UI
    let titleLabel = UILabel().then {
        $0.text = "DIARY"
        $0.textAlignment = .left
        $0.textColor = R.color.mainColor()
        $0.font = Font.titleFont
    }
    
    let loginTextField = DiaryTextField().then {
        $0.textField.placeholder = "ID"
        $0.textField.keyboardType = .emailAddress
    }
    
    let PassWordTextField = DiaryTextField().then {
        $0.textField.placeholder = "Password"
        $0.textField.keyboardType = .default
        $0.textField.isSecureTextEntry = true
    }
    
    let loginButton = UIButton().then {
        $0.backgroundColor = R.color.mainColor()
        $0.layer.cornerRadius = 7
    }
    
    let loginImage = UIImageView().then {
        $0.image = R.image.loginIllustration()
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
        self.view.addSubview(self.loginTextField)
        self.view.addSubview(self.PassWordTextField)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.loginButton)
        self.view.addSubview(self.loginImage)
    }
    
    override func makeConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(Metric.titleLabelTop)
            $0.centerX.equalTo(safeArea)
        }
        
        self.loginTextField.snp.makeConstraints {
            $0.left.equalTo(safeArea).offset(Metric.textFieldSide)
            $0.right.equalTo(safeArea).offset(-Metric.textFieldSide)
            $0.bottom.equalTo(self.titleLabel.snp.bottom).offset(self.view.frame.height / 5)
            $0.height.equalTo(Metric.textFieldHeight)
        }
        
        self.PassWordTextField.snp.makeConstraints {
            $0.left.equalTo(safeArea).offset(Metric.textFieldSide)
            $0.right.equalTo(safeArea).offset(-Metric.textFieldSide)
            $0.top.equalTo(self.loginTextField.snp.bottom)
            $0.height.equalTo(Metric.textFieldHeight)
        }
        
        self.loginButton.snp.makeConstraints {
            $0.top.equalTo(self.PassWordTextField.snp.bottom).offset(Metric.buttonTop)
            $0.left.equalTo(safeArea).offset(Metric.buttonSide)
            $0.right.equalTo(safeArea).offset(-Metric.buttonSide)
            $0.height.equalTo(Metric.buttonHeight)
        }
        
        self.loginImage.snp.makeConstraints {
            $0.height.equalTo(Metric.imageHeight)
            $0.width.equalTo(Metric.imageWidth)
            $0.bottom.equalTo(safeArea)
            $0.left.equalTo(safeArea).offset(Metric.imageLeft)
        }
    }
    
    // MARK: - Configuring
    func bind(reactor: LoginViewReactor) {
        loginButton.rx.tap.asObservable()
            .map { Reactor.Action.login }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
}
