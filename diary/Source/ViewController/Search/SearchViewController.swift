//
//  SearchViewController.swift
//  diary
//
//  Created by 김부성 on 2021/10/03.
//

import UIKit

import ReactorKit
import ReusableKit
import RxDataSources
import Atributika

final class SearchViewController: BaseViewController, View {
    
    typealias Reactor = SearchViewReactor
    
    // MARK: - Constants
    fileprivate struct Metric {
        // NavigationPadding
        static let leftNavigativePadding = 10.f
        static let rightNavigativePadding = 10.f
        
        static let headerHeight = 110.f
    }
    
    fileprivate struct Font {
        static let searchBarPlaceholder = Style.font(.systemFont(ofSize: 16, weight: .medium))
    }
    
    fileprivate struct Reusable {
        static let searchHeaderView = ReusableView<SearchSectionHeaderView>()
        static let searchCell = ReusableCell<SearchCell>()
    }
    
    // MARK: - Properties
    fileprivate let dataSource: RxTableViewSectionedReloadDataSource<SearchViewSection>
    
    // MARK: - UI
    let searchBar = DiarySearchBar().then {
        $0.searchTextField.attributedPlaceholder = "검색어를 입력하세요.".styleAll(Font.searchBarPlaceholder).attributedString
    }
    
    let tableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.separatorStyle = .singleLine
        
        $0.register(Reusable.searchCell)
        $0.register(Reusable.searchHeaderView)
    }
    
    let headerView = SearchHeaderView()
    
    let leftNavigativePadding = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil).then {
        $0.width = Metric.leftNavigativePadding
    }
    
    let rightNavigativePadding = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil).then {
        $0.width = Metric.rightNavigativePadding
    }
    
    // MARK: - Inintializing
    init(reactor: Reactor) {
        self.dataSource = Self.dataSourceFactory()
        super.init()
        defer {
            self.reactor = reactor
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private static func dataSourceFactory() -> RxTableViewSectionedReloadDataSource<SearchViewSection> {
        return .init(configureCell: { dataSource, tableView, indexPath, sectionItem in
            switch sectionItem {
            case let .diary(reactor):
                let cell = tableView.dequeue(Reusable.searchCell, for: indexPath)
                cell.reactor = reactor
                return cell
            }
        })
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItems = [leftNavigativePadding]
        self.navigationItem.rightBarButtonItems = [rightNavigativePadding]
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.tableView.tableHeaderView = self.headerView
        self.navigationItem.titleView = self.searchBar
        
        self.view.addSubview(self.tableView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.tableView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSafeArea(self.view)
        }
        
        self.headerView.snp.makeConstraints {
            $0.height.equalTo(Metric.headerHeight)
            $0.width.equalToSafeArea(self.view)
        }
    }
    
    // MARK: - Configuring
    func bind(reactor: SearchViewReactor) {
        // Input
        self.searchBar.leftButton.rx.tap.asObservable()
            .map { Reactor.Action.popViewController }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.searchBar.rx.searchButtonClicked.asObservable()
            .map { [weak self] in
                Reactor.Action.search((self?.searchBar.text)!)
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // Output
        reactor.state.map { $0.sections }
            .bind(to: self.tableView.rx.items(dataSource: self.dataSource))
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isEmpty }.asObservable()
            .bind(to: self.headerView.rx.isHidden)
            .disposed(by: disposeBag)
        
        // View
        self.tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        self.tableView.rx.itemSelected
            .subscribe(onNext: { [weak tableView] indexPath in
                tableView?.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: disposeBag)
        
        self.searchBar.rx.searchButtonClicked.asObservable()
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.headerView.title.text = "#" + self.searchBar.text!
            })
            .disposed(by: disposeBag)
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeue(Reusable.searchHeaderView)
        view?.titleLabel.text = self.reactor?.currentState.sectionDates[section].searchString
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
}

