//
//  AppDelegate.swift
//  Example
//
//  Created by Hoang Nguyen on 28/10/23.
//

import ThreadWatcher
import UIKit
@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_: UIApplication,
                     didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        let threadWatcher = ThreadWatcher(threshold: 4.0)
        threadWatcher.start()
        threadWatcher.delegate = self
        return true
    }
}

extension AppDelegate: ThreadWatcherDelegate {
    func hangoutOccurred(_: ThreadWatcher,
                         withDuration duration: TimeInterval)
    {
        DispatchQueue.main.async {
            let timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .medium)
            let message = "Hangout Occurred: \(timestamp) - Duration: \(duration)\n\(self.getDebugInfo())"
            print(message)
        }
    }

    private func getDebugInfo() -> String {
        var debugInfo = ""
        if let currentViewController = UIApplication.getTopViewcontroller() {
            debugInfo += "Current ViewController: \(String(describing: currentViewController))\n"
        }
        let stackTrace = Thread.callStackSymbols.joined(separator: "\n")
        debugInfo += "Stack Trace:\n\(stackTrace)"
        return debugInfo
    }
}

extension UIApplication {
    class func getTopViewcontroller(
        controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
    ) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return getTopViewcontroller(controller: navigationController.visibleViewController)
        }

        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return getTopViewcontroller(controller: selected)
            }
        }

        if let presented = controller?.presentedViewController {
            return getTopViewcontroller(controller: presented)
        }

        return controller
    }
}
