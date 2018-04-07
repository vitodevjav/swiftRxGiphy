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
    private var data: Variable<[GIPHYData]>
    private var currentOffset = 0
    private var contentSize: ContentSize = .defaultSize

    private let networkController = NetworkController()

    init() {
        data = Variable([])
    }
}

extension SearchViewInteractor: TableViewRxDataSource {
	var items: Variable<[GIPHYData]> {
		return data
	}
	
    func fetch(with searchTerm: String?, isTrended: Bool) {
		networkController.searchImages(requestType: .trending, requestedName: searchTerm, contentSize: contentSize, offset: currentOffset)
			.subscribe(onNext: { value in
				self.data.value = value
			})
			.dispose()
    }
}

