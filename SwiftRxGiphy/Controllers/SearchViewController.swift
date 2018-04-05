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

    func configureTableView() {

        guard let view = view as? SearchView else { return }

        let reactiveTable = view.tableView.rx
        interactor?.items.asObservable()
            .bind(to: reactiveTable.items(cellIdentifier: "Cell", cellType: GifTableViewCell.self)) { row, element, cell in
                cell.textLabel?.text = "\(element) @ row \(row)"
            }
            .disposed(by: disposeBag)
    }
}
