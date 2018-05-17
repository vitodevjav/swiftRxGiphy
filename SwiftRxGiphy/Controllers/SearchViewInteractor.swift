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
    private var disposeBag = DisposeBag()
    private weak var controller: SearchViewController?
    private let networkController = NetworkController()

    init(controller: SearchViewController) {
        data = Variable([])
        self.controller = controller

        addObservers()
    }

    func addObservers() {
        controller?.searchTerm.asObservable()
            .subscribe(onNext: { value in
                self.data.value.removeAll()
                self.fetch(with: value)
        }).disposed(by: disposeBag)
    }
}

extension SearchViewInteractor: TableViewRxDataSource {
    func setOffset(_ offset: Int) {
        currentOffset = offset
    }

	var items: Variable<[GIPHYData]> {
		return data
	}
	
    func fetch(with searchTerm: String = "") {
        let requestType: RequestType = searchTerm.isEmpty ? .trending : .search
		networkController.searchImages(requestType: requestType, requestedName: searchTerm, contentSize: contentSize, offset: currentOffset)
			.subscribe(onNext: { value in
				self.data.value += value
			})
            .disposed(by: disposeBag)
    }
}

