//
//  TableViewExtension.swift
//  SwiftRxGiphy
//
//  Created by Kazakevich, Vitaly on 5/8/18.
//  Copyright © 2018 Vitali Kazakevich. All rights reserved.
//

import Foundation
import UIKit

public extension UITableView {

    public func beginRefreshing() {
        guard let refreshControl = refreshControl, !refreshControl.isRefreshing else {
            return
        }

        refreshControl.beginRefreshing()

        refreshControl.sendActions(for: .valueChanged)

        let contentOffset = CGPoint(x: 0, y: -refreshControl.frame.height)
        setContentOffset(contentOffset, animated: true)
    }

    public func endRefreshing() {
        refreshControl?.endRefreshing()
    }

}
