//
//  Gifka.swift
//  SwiftRxGiphy
//
//  Created by Kazakevich, Vitaly on 3/28/18.
//  Copyright © 2018 Vitali Kazakevich. All rights reserved.
//

import Foundation

class Gifka {
    var identifier: String
    var rating: GifRating
    var title: String
    var gifUrl: URL?
    var previewUrl: URL?
    var trendingDate: Date?

    var height: Double
    var width: Double

    init(giphy: GIPHYData) {
        self.identifier = giphy.identifier
        self.rating = GifRating(rawValue: giphy.rating) ?? .no
        self.gifUrl = URL(string: giphy.image.gifUrl)
        self.previewUrl = URL(string: giphy.image.previewUrl)
        self.title = giphy.title
        self.trendingDate = giphy.trendingDate
        self.height = giphy.image.height
        self.width = giphy.image.width
    }
}

