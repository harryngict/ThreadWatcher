//
//  UIApplication+Extensions.swift
//  ThreadWatcher
//
//  Created by Hoang Nguyen on 3/12/23.
//

import UIKit

extension UIApplication {
    class func topViewController(base: UIViewController? =
        UIApplication.shared.keyWindow?.rootViewController) -> UIViewController?
    {
        if let navigationController = base as? UINavigationController {
            return topViewController(base: navigationController.visibleViewController)
        } else if let tabBarController = base as? UITabBarController, let selected = tabBarController.selectedViewController {
            return topViewController(base: selected)
        } else if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
