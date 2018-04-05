//
//  NetworkController.swift
//  SwiftRxGiphy
//
//  Created by Kazakevich, Vitaly on 3/30/18.
//  Copyright © 2018 Vitali Kazakevich. All rights reserved.
//

import Foundation

class NetworkController {

    func searchImages(requestType: RequestType = .trending, requestedName: String? = nil, contentSize: ContentSize = .defaultSize, offset: Int = 0, rating: GifRating? = nil) {
        let request = RequestBuilder(requestType: requestType,
                                     searchTerm: requestedName,
                                     contentSize: contentSize,
                                     offset: offset,
                                     rating: rating)
            .build()

        guard let searchRequest = request else { return }
        sendRequest(searchRequest)
    }

    private func sendRequest(_ request: URLRequest) {

		URLSession.shared.dataTask(with: request) { data, response, error in
			guard error == nil,
				let responseData = data,
				let jsonDictionary = try? JSONSerialization.jsonObject(with: responseData) as? [String: Any]
				else { return }
			
				
            }.resume()
    }
}
