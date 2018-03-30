//
//  AppDelegate.swift
//  SwiftRxGiphy
//
//  Created by Vitali Kazakevich on 3/25/18.
//  Copyright © 2018 Vitali Kazakevich. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else { return false }

        window.rootViewController = UINavigationController(rootViewController: SearchViewController())
        window.makeKeyAndVisible()
		return true
	}

}

