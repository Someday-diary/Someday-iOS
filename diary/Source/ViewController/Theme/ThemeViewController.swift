//
//  ThemeViewController.swift
//  diary
//
//  Created by 김부성 on 2021/10/06.
//

import UIKit

import ReusableKit
import ReactorKit

final class ThemeViewController: BaseViewController, View {
    
    typealias Reactor = ThemeViewReactor
    
    // MARK: - Constants
    fileprivate struct Metric {
        
    }
    
    fileprivate struct Font {
        
    }
    
    // MARK: - Properties
    
    // MARK: - UI
    
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
        
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
    }
    
    // MARK: - Configuring
    func bind(reactor: ThemeViewReactor) {
        
    }
}
