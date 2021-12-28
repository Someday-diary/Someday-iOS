//
//  FeedbackViewController.swift
//  diary
//
//  Created by 김부성 on 2021/12/27.
//

import UIKit

import ReactorKit

final class FeedbackViewController: BaseViewController, View {
    
    typealias Reactor = FeedbackViewReactor
    
    // MARK: - Constants
    fileprivate struct Metric {
        
    }
    
    fileprivate struct Font {
        
    }
    
    fileprivate struct Style {
        
    }
    
    // MARK: - Properties
    
    // MARK: - UI
    private let titleTextView: DiaryTextView = DiaryTextView().then {
        $0.placeholder = "제목"
    }
    
    // MARK: - Inintializing
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
        
        self.view.addSubview(self.titleTextView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.titleTextView.pin.all(self.view.pin.safeArea)
    }
    
    // MARK: - Configuring
    func bind(reactor: Reactor) {
        
    }
}

