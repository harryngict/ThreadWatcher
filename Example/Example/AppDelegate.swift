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
                         current stackTrace: String,
                         withDuration duration: TimeInterval)
    {
        print("hangoutOccurred: \(duration)")
        print("\(stackTrace)")
    }
}
