//
//  SearchView.swift
//  SwiftRxGiphy
//
//  Created by Kazakevich, Vitaly on 3/28/18.
//  Copyright © 2018 Vitali Kazakevich. All rights reserved.
//

import Foundation
import UIKit

class SearchView: UIView {
    private let viewInsets: CGFloat = 5.0
    private let searchBarHeight: CGFloat = 40.0
    private let verticalViewMargin: CGFloat = 5.0

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(GifTableViewCell.self, forCellReuseIdentifier: GifTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    init() {
        super.init(frame: .zero)

        addSubview(tableView)
        addSubview(searchBar)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([searchBar.topAnchor.constraint(equalTo: topAnchor, constant: viewInsets),
                                     searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: viewInsets),
                                     searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -viewInsets),
                                     searchBar.heightAnchor.constraint(equalToConstant: searchBarHeight),

                                     tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: verticalViewMargin),
                                     tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: viewInsets),
                                     tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -viewInsets),
                                     tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: viewInsets)
                                     ])
    }
}
