//
//  SearchViewController.swift
//  SwiftRxGiphy
//
//  Created by Kazakevich, Vitaly on 3/27/18.
//  Copyright © 2018 Vitali Kazakevich. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol TableViewRxDataSource {
    var items: Variable<[GIPHYData]> { get }
    func fetch (with searchTerm: String?, isTrended: Bool)
    func setOffset(_ offset: Int)
}

class SearchViewController: UIViewController {

    private let interactor: TableViewRxDataSource?
    private var searchTerm: Variable<String>
    private var isTrended: Variable<Bool>
    let isRefreshing: Variable<Bool> = Variable(false)

    init() {
        searchTerm = Variable("")
        isTrended = Variable(false)
        interactor = SearchViewInteractor()
        super.init(nibName: nil, bundle: nil)
    }

    let disposeBag = DisposeBag()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = SearchView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    func configureView() {

        guard let view = view as? SearchView else { return }

        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.tableView.refreshControl = refreshControl

        refreshControl
            .rx.controlEvent(.valueChanged)
            .subscribe(onNext: {
                refreshControl.beginRefreshing()
                self.interactor?.fetch(with: self.searchTerm.value, isTrended: self.isTrended.value)
                self.interactor?.items.asObservable()
                    .observeOn(MainScheduler.instance)
                    .subscribe(
                        onNext: { (_) in
                            refreshControl.endRefreshing()
                    })
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)

        isRefreshing
            .asObservable()
            .bind(onNext: { (isRefreshing) in
//                view.tableView.reloadEmptyDataSet()
            })
            .disposed(by: disposeBag)

        let reactiveTable = view.tableView.rx
        interactor?.items.asObservable()
            .bind(to: reactiveTable.items) { collectionView, index, item in
                let cell = collectionView.dequeueReusableCell(withIdentifier: GifTableViewCell.identifier, for: IndexPath(item: index, section: 0))
                if let animatedCell = cell as? GifTableViewCell {
                    animatedCell.configure(with: item)
                }
                return cell
            }
            .disposed(by: disposeBag)

        reactiveTable.willDisplayCell
            .subscribe(onNext: { cell, index in
                guard self.isRefreshing.value,
                    let itemsCount = self.interactor?.items.value.count,
                    index.row == itemsCount - 1
                    else { return }
                self.interactor?.setOffset(itemsCount)
                self.isRefreshing.value = true
                self.interactor?.fetch(with: self.searchTerm.value, isTrended: self.isTrended.value)
            })
            .disposed(by: disposeBag)

        view.searchBar.rx.text.changed
            .throttle(0.3, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] value in
                self?.searchTerm.value = value ?? ""
            })
            .disposed(by: disposeBag)

        view.trendedSwitch.rx.isOn
            .subscribe(onNext: { [weak self] value in
                self?.isTrended.value = value
            })
            .disposed(by: disposeBag)

        Observable.combineLatest(searchTerm.asObservable(),
                                 isTrended.asObservable(),
                                 resultSelector: { _, _ in
        }).subscribe { _ in
            self.interactor?.fetch(with: self.searchTerm.value, isTrended: self.isTrended.value)
            }
            .disposed(by: disposeBag)
    }
}
