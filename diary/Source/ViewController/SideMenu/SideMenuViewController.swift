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
    let button = UIButton().then {
        $0.setTitleColor(.blue, for: .normal)
        $0.setTitle("색상 변경", for: .normal)
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
        self.view.addSubview(button)
    }
    
    override func makeConstraints() {
        self.button.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        self.button.rx.tap
            .subscribe(onNext: {
                print("button tapped")
                themeService.switch(.blue)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Configuring
    func bind(reactor: SideMenuViewReactor) {
        
    }

}
