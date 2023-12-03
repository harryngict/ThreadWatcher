//
//  ThreadWatcherDelegate.swift
//  ThreadWatcher
//
//  Created by Hoang Nguyen on 3/12/23.
//

import Foundation

public protocol ThreadWatcherDelegate: AnyObject {
    func hangoutOccurred(_ watcher: ThreadWatcher, withDuration duration: TimeInterval)
}
