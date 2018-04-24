//
//  Gifka.swift
//  SwiftRxGiphy
//
//  Created by Kazakevich, Vitaly on 3/28/18.
//  Copyright © 2018 Vitali Kazakevich. All rights reserved.
//

import Foundation
import CoreData

@objc(Gifka)
class Gifka: NSManagedObject {
    @NSManaged var title: String
	@NSManaged var url: String
	@NSManaged var thumbnailUrl: String
	@NSManaged var rating: String
	@NSManaged var width: String
	@NSManaged var height: String
}

