//
//  WriteViewController.swift
//  diary
//
//  Created by 김부성 on 2021/09/04.
//

import UIKit
import UITextView_Placeholder
import ReactorKit

final class WriteViewController: BaseViewController, View {
    
    // MARK: - Properties
    typealias Reactor = WriteViewReactor
    
    // MARK: - Constants
    fileprivate struct Font {
        static let textViewFont = UIFont.systemFont(ofSize: 16, weight: .light)
    }
    
    // MARK: - UI
    let textView = UITextView().then {
        $0.placeholder = "오늘 하루를 기록하세요."
        $0.theme.placeholderColor = themed { $0.mainColor }
        $0.theme.tintColor = themed { $0.mainColor }
        $0.font = Font.textViewFont
    }
    
    // MARK: - Inintializing
    init(reactor: WriteViewReactor) {
        super.init()
        
        self.reactor = reactor
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
        
        self.view.addSubview(textView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.textView.snp.makeConstraints {
            $0.edges.equalToSafeArea(self.view)
        }
    }
    
    func bind(reactor: WriteViewReactor) {
        
    }

}
