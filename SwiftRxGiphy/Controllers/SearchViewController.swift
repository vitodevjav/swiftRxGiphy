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
    var items: Variable<[Gifka]> { get }
    func fetch (with searchTerm: String?)
}

class SearchViewController: UIViewController {
    var interactor: TableViewRxDataSource?

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    let disposeBag = DisposeBag()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = SearchView()
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
                self?.interactor?.fetch(with: value)
            })
            .disposed(by: disposeBag)
    }
}
