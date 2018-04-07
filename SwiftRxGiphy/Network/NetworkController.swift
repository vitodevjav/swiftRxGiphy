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

	func searchImages(requestType: RequestType = .trending, requestedName: String? = nil, contentSize: ContentSize = .defaultSize, offset: Int = 0, rating: GifRating? = nil) -> Observable<[GIPHYData]>? {
        let request = RequestBuilder(requestType: requestType,
                                     searchTerm: requestedName,
                                     contentSize: contentSize,
                                     offset: offset,
                                     rating: rating)
            .build()

        guard let searchRequest = request else { return nil }
        return sendRequest(searchRequest)
    }
	
	private func sendRequest(_ request: URLRequest) -> Observable<[GIPHYData]> {
		return Observable<[GIPHYData]>.create { observer in
			let task: URLSessionDataTask = URLSession.shared.dataTask(with: request) { data, response, error in
				guard error == nil,
					let responseData = data
					else {
						observer.onError(error!)
						return
				}
				
				let decoder = JSONDecoder()
				decoder.dateDecodingStrategy = .formatted(DateFormatter.giphyFormatter)
				
				guard let giphyResponse = try? decoder.decode(GIPHYResponse.self, from: responseData) else {
					observer.onCompleted()
					return
				}
			
				let gifs = giphyResponse.data
					.filter { $0.base != nil }
					.map { $0.base! }
				
				observer.onNext(gifs)
				observer.onCompleted()
				}
			task.resume()
			return Disposables.create {
				task.cancel()
			}
		}
	}
	
}
