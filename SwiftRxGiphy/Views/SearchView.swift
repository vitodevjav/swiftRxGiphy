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

    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(GifTableViewCell.self, forCellReuseIdentifier: GifTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 200.0
        tableView.rowHeight = UITableViewAutomaticDimension
        return tableView
    }()

    var trendedSwitch: UISwitch = {
        let switchView = UISwitch()
        switchView.translatesAutoresizingMaskIntoConstraints = false
        return switchView
    }()

    init() {
        super.init(frame: .zero)

        addSubview(tableView)
        addSubview(searchBar)
        addSubview(trendedSwitch)
        configureConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: viewInsets),
                                     searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: viewInsets),

                                     trendedSwitch.leadingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: viewInsets),
                                     trendedSwitch.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -viewInsets),
                                     trendedSwitch.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: viewInsets),

                                     tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: verticalViewMargin),
                                     tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: viewInsets),
                                     tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -viewInsets),
                                     tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: viewInsets)
            ])
    }
}
