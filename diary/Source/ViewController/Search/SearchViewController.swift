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
import RxGesture
import Atributika

final class SearchViewController: BaseViewController, ReactorKit.View {
    
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
        static let noDiaryFont = UIFont.systemFont(ofSize: 16, weight: .medium)
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
        $0.separatorStyle = .none
        
        $0.register(Reusable.searchCell)
        $0.register(Reusable.searchHeaderView)
    }
    
    let noDiaryLabel = UILabel().then {
        $0.text = "# 검색 결과가 없습니다."
        $0.font = Font.noDiaryFont
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
        self.view.addSubview(self.noDiaryLabel)
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
        
        self.noDiaryLabel.snp.makeConstraints {
            $0.center.equalToSafeArea(self.view)
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
                self?.searchBar.endEditing(true)
                return Reactor.Action.search((self?.searchBar.text)!)
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.rx.viewDidAppear.asObservable()
            .map { [weak self] _ in
                Reactor.Action.search(self?.reactor?.currentState.searchString ?? "")
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // Output
        reactor.state.map { $0.sections }
            .bind(to: self.tableView.rx.items(dataSource: self.dataSource))
            .disposed(by: disposeBag)
        
        reactor.state.map { "#" + $0.searchString }.asObservable()
            .bind(to: self.headerView.title.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isEmpty }.asObservable()
            .bind(to: self.headerView.rx.isHidden)
            .disposed(by: disposeBag)
        
        reactor.state.map { !$0.isEmpty }.asObservable()
            .bind(to: self.noDiaryLabel.rx.animated.fade(duration: 0.2).isHidden)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isLoading }.asObservable()
            .distinctUntilChanged()
            .bind(to: self.activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        self.searchBar.text = reactor.initialState.searchString
        
        // View
        self.tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        self.tableView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.searchBar.endEditing(true)
            }).disposed(by: disposeBag)
        
        self.tableView.rx.itemSelected
            .subscribe(onNext: { [weak tableView] indexPath in
                tableView?.deselectRow(at: indexPath, animated: true)
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}
