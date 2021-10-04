//
//  SearchViewController.swift
//  diary
//
//  Created by 김부성 on 2021/10/03.
//

import UIKit

import ReactorKit
import Atributika

final class SearchViewController: BaseViewController, View {
    
    typealias Reactor = SearchViewReactor
    
    // MARK: - Constants
    fileprivate struct Metric {
        
    }
    
    fileprivate struct Font {
        static let searchBarPlaceholder = Style.font(.systemFont(ofSize: 16, weight: .medium))
    }
    
    // MARK: - Properties
    
    // MARK: - UI
    let searchBar = DiarySearchBar().then {
        $0.searchTextField.attributedPlaceholder = "검색어를 입력하세요.".styleAll(Font.searchBarPlaceholder).attributedString
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
        
        self.navigationItem.titleView = self.searchBar
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
    }
    
    // MARK: - Configuring
    func bind(reactor: SearchViewReactor) {
        
    }
}

