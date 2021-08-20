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
        $0.color = .secondarySystemBackground
    }
    
    // MARK: - Initializing
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit : \(type(of: self)): \(#function)")
        self.activityIndicatorView.stopAnimating()
    }
    
    // MARK: - Rx
    var disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()
        self.makeConstraints()
        self.setupLocalization()

        view.backgroundColor = .systemBackground
        
        view.addSubview(self.activityIndicatorView)
        activityIndicatorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    func setupLayout() {
        // add Views
    }
    
    func makeConstraints() {
        // Constraints
    }
    
    func setupLocalization() {
        // localizations
    }
    
    

}

