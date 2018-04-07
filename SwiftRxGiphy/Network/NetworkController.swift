//
//  NetworkController.swift
//  SwiftRxGiphy
//
//  Created by Kazakevich, Vitaly on 3/30/18.
//  Copyright © 2018 Vitali Kazakevich. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class NetworkController {

	func searchImages(requestType: RequestType = .trending, requestedName: String? = nil, contentSize: ContentSize = .defaultSize, offset: Int = 0, rating: GifRating? = nil) -> Observable<Any>? {
        let request = RequestBuilder(requestType: requestType,
                                     searchTerm: requestedName,
                                     contentSize: contentSize,
                                     offset: offset,
                                     rating: rating)
            .build()

        guard let searchRequest = request else { return nil }
        return sendRequest(searchRequest)
    }
	
	private func sendRequest(_ request: URLRequest) -> Observable<Any> {
		return Observable<Any>.create { observer in
			let task: URLSessionDataTask = URLSession.shared.dataTask(with: request) { data, response, error in
				guard error == nil,
					let responseData = data
					else {
						observer.onError(error!)
						return
				}
				
				let decoder = JSONDecoder()
				decoder.dateDecodingStrategy = .formatted(DateFormatter.giphyFormatter)
				
				let giphyResponse = try? decoder.decode(GIPHYResponse.self, from: responseData)
				let gifs = giphyResponse?.data.map {
					
				}
				observer.onNext(giphyResponse)
				observer.onCompleted()
				}
			task.resume()
			return Disposables.create {
				task.cancel()
			}
		}
	}
	
}
