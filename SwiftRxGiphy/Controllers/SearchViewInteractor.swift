//
//  SearchViewInteractor.swift
//  SwiftRxGiphy
//
//  Created by Kazakevich, Vitaly on 4/5/18.
//  Copyright © 2018 Vitali Kazakevich. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewInteractor {
    private var data: Variable<[Gifka]>
    private var currentOffset = 0
    private var contentSize: ContentSize = .defaultSize

    private let networkController = NetworkController()

    init() {
        data = Variable([])
    }
}

extension SearchViewInteractor: TableViewRxDataSource {
    func fetch(with searchTerm: String? = "") {
        networkController.searchImages(requestType: .trended, requestedName: searchTerm, contentSize: contentSize.rawValue, offset: currentOffset)
    }

    var items: Variable<[Gifka]> { return data }
}

