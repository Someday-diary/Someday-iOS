//
//  BaseViewController.swift
//  diary
//
//  Created by 김부성 on 2021/08/19.
//

import UIKit

import RxSwift
import RxCocoa

class BaseViewController: UIViewController {
    
    
    // MARK: - UI
    let activityIndicatorView = UIActivityIndicatorView(style: .large).then {
        $0.color = .gray
    }
    
    // MARK: - Initializing
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - Rx
    var disposeBag = DisposeBag.init()
    
    // MARK: - View Life Cycle
    deinit {
        print("deinit : \(type(of: self)): \(#function)")
        self.activityIndicatorView.stopAnimating()
    }
    
    // MARK: - Layout Constraint
    private(set) var didSetupConstraints = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.setNeedsUpdateConstraints()
        
        self.setupStyle()
    }
    
    override func updateViewConstraints() {
        if !self.didSetupConstraints {
            self.setupLayout()
            self.setupConstraints()
            self.didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
    
    func setupLayout() {
        // add Views
        view.addSubview(self.activityIndicatorView)
    }
    
    func setupConstraints() {
        // Constraints
        activityIndicatorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func setupLocalization() {
        // localizations
    }
    
    // MARK: - Setup
    func setupStyle() {
        view.backgroundColor = R.color.diaryBackgroundColor()
    }
    

}

