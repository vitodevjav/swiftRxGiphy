//
//  ParseJSON.swift
//  SwiftRxGiphy
//
//  Created by Vitali Kazakevich on 4/6/18.
//  Copyright © 2018 Vitali Kazakevich. All rights reserved.
//

import Foundation

struct GIPHYResponse: Decodable {
	
	var data: [FailableDecodable<GIPHYData>] = []
	var meta: GIPHYMeta
	var pagination: GIPHYPagination
	
}

struct GIPHYData: Decodable {
	
	var identifier: String
	var rating: String
	var title: String
	var image: GIPHYImage
	var trendingDate: Date?
	
	enum CodingKeys: String, CodingKey {
		case identifier = "id"
		case rating
		case title
		case image = "images"
		case trendingDate = "trending_datetime"
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		identifier = try container.decode(String.self, forKey: .identifier)
		rating = try container.decode(String.self, forKey: .rating)
		title = try container.decode(String.self, forKey: .title)
		image = try container.decode(GIPHYImage.self, forKey: .image)
		trendingDate = try? container.decode(Date.self, forKey: .trendingDate)
	}
	
}

struct GIPHYImage: Decodable {
	
	var gifUrl: String
	var previewUrl: String
	
	var height: Double
	var width: Double
	
	enum CodingKeys: String, CodingKey {
		case gif = "fixed_height"
		case preview = "fixed_height_still"
	}
	
	enum GifKeys: String, CodingKey {
		case gifUrl = "url"
		case height
		case width
	}
	
	enum PreviewKeys: String, CodingKey {
		case previewUrl = "url"
	}
	
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		
		let gif = try values.nestedContainer(keyedBy: GifKeys.self, forKey: .gif)
		gifUrl = try gif.decode(String.self, forKey: .gifUrl)
		height = Double(try gif.decode(String.self, forKey: .height)) ?? 100
		width = Double(try gif.decode(String.self, forKey: .width)) ?? 100
		
		let preview = try values.nestedContainer(keyedBy: PreviewKeys.self, forKey: .preview)
		previewUrl = try preview.decode(String.self, forKey: .previewUrl)
	}
	
}

struct GIPHYMeta: Decodable {
	
	var status: Int
	var message: String
	
	enum CodingKeys: String, CodingKey {
		case status
		case message = "msg"
	}
	
}

struct GIPHYPagination: Decodable {
	
	var totalCount: Int
	var count: Int
	var offset: Int
	
	enum CodingKeys: String, CodingKey {
		case totalCount = "total_count"
		case count
		case offset
	}
	
}

struct FailableDecodable<Base : Decodable> : Decodable {
	
	let base: Base?
	
	init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		self.base = try? container.decode(Base.self)
	}
}

extension DateFormatter {
	
	static let giphyFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
		return formatter
	}()
	
}
