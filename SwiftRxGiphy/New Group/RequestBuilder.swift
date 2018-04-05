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
    private let hostName = "http://api.giphy.com/v1/gifs/"
    let requestType: RequestType
    let requestedName: String?
    let contentSize: Int?
    let offset: Int?

    func build() -> URLRequest? {
        let urlString = hostName + ""
        let url = URL(string: urlString)
        guard let requestUrl = url else { return nil }

        return URLRequest(url: requestUrl)
    }
}
