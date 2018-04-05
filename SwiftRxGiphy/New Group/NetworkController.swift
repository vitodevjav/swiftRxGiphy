//
//  NetworkController.swift
//  SwiftRxGiphy
//
//  Created by Kazakevich, Vitaly on 3/30/18.
//  Copyright © 2018 Vitali Kazakevich. All rights reserved.
//

import Foundation

class NetworkController {

    func searchImages(requestType: RequestType = .trended, requestedName: String? = nil, contentSize: Int = 20, offset: Int = 0) {
        let request = RequestBuilder(requestType: requestType,
                                     requestedName: requestedName,
                                     contentSize: contentSize,
                                     offset: offset)
            .build()

        guard let searchRequest = request else { return }
        sendRequest(searchRequest)
    }

    private func sendRequest(_ request: URLRequest) {

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error != nil else { return }

            }.resume()
    }
}
