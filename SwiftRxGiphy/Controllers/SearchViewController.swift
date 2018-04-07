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
}

class SearchViewController: UIViewController {

    private let interactor: TableViewRxDataSource?
    private var searchTerm: Variable<String>
    private var isTrended: Variable<Bool>

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

        let reactiveTable = view.tableView.rx
        interactor?.items.asObservable()
            .bind(to: reactiveTable.items(cellIdentifier: "Cell", cellType: GifTableViewCell.self)) { row, element, cell in
                cell.textLabel?.text = "\(element) @ row \(row)"
            }
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
