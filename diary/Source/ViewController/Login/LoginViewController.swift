//
//  LoginViewController.swift
//  diary
//
//  Created by 김부성 on 2021/08/24.
//

import UIKit

class LoginViewController: BaseViewController {
    
    // MARK: - Constants
    fileprivate struct Metric {
        // titleLabel
        static let titleLabelTop = 100.f
        static let titleLabelLeft = 37.f
        
        // textField
        static let textFieldSide = 50.f
        static let textFieldHeight = 65.f
    }
    
    fileprivate struct Font {
        static var titleFont = UIFont.systemFont(ofSize: 28, weight: .semibold)
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
    
    // MARK: - Initializing
    override init() {
        super.init()
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
    }
    
    override func makeConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(Metric.titleLabelTop)
            $0.left.equalTo(safeArea).offset(Metric.titleLabelLeft)
        }
        
        self.loginTextField.snp.makeConstraints {
            $0.left.equalTo(safeArea).offset(Metric.textFieldSide)
            $0.right.equalTo(safeArea).offset(-Metric.textFieldSide)
            $0.bottom.equalTo(safeArea.snp.centerY)
            $0.height.equalTo(Metric.textFieldHeight)
        }
        
        self.PassWordTextField.snp.makeConstraints {
            $0.left.equalTo(safeArea).offset(Metric.textFieldSide)
            $0.right.equalTo(safeArea).offset(-Metric.textFieldSide)
            $0.top.equalTo(safeArea.snp.centerY)
            $0.height.equalTo(Metric.textFieldHeight)
        }
    }
}
