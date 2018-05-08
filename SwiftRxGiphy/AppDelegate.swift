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

extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}

class MessageCenter {

    static let sharedInstance = MessageCenter()

    private init() {}

    func showMessage(title: String, message: String, buttonTitle: String, completion: @escaping ()->()) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { (_) in
            completion()
        }))
        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
    }

}
