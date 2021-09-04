//
//  WriteViewController.swift
//  diary
//
//  Created by 김부성 on 2021/09/04.
//

import UIKit

import ReactorKit

final class WriteViewController: BaseViewController, View {
    
    // MARK: - Properties
    typealias Reactor = WriteViewReactor
    
    // MARK: - Inintializing
    init(reactor: WriteViewReactor) {
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func bind(reactor: WriteViewReactor) {
        
    }

}
