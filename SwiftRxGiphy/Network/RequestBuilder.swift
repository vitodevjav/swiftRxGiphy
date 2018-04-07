//
//  RequestBuilder.swift
//  SwiftRxGiphy
//
//  Created by Kazakevich, Vitaly on 3/30/18.
//  Copyright © 2018 Vitali Kazakevich. All rights reserved.
//

import Foundation

struct RequestBuilder {
    private let apiKey = "ydW1gRhQ50p3hk74lioamIoTzIK6Clg4"
    private let hostName = "https://api.giphy.com/v1/gifs/"
    let requestType: RequestType
    let searchTerm: String?
    let contentSize: ContentSize
    let offset: Int?
    let rating: GifRating?

    func build() -> URLRequest? {
		let composedHost = hostName + requestType.rawValue
		var urlComponents = URLComponents(string: composedHost)
        urlComponents?.queryItems = [URLQueryItem(name: "apiKey", value: apiKey),
									 URLQueryItem(name: "q", value: searchTerm),
									 URLQueryItem(name: "limit", value: String(describing: contentSize.rawValue)),
									 URLQueryItem(name: "offset", value:  String(describing: offset ?? 0) ),
									 URLQueryItem(name: "rating", value: rating?.rawValue),
		]
		guard let url = urlComponents?.url else { return nil }

		var request = URLRequest(url: url)
		request.httpMethod = HTTPMethod.GET.rawValue
        return request	
    }
}
