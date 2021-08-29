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
    
    // MARK: - UI
    let navigationAppearance = UINavigationBarAppearance().then {
        $0.configureWithTransparentBackground()
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
        self.navigationController?.navigationBar.standardAppearance = navigationAppearance
    }
    
    // MARK: - Configuring
    func bind(reactor: SideMenuViewReactor) {
        
    }

}
