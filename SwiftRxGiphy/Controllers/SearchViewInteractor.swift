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
    init() {
        data = Variable([])
    }
}

extension SearchViewInteractor: TableViewRxDataSource {
    func fetch(with searchTerm: String? = "") {
        
    }

    var items: Variable<[Gifka]> { return data }
}

