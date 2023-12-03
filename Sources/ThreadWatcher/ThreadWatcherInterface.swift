//
//  ThreadWatcherInterface.swift
//  ThreadWatcher
//
//  Created by Hoang Nguyen on 3/12/23.
//

import Foundation

public protocol ThreadWatcherInterface: AnyObject {
    var delegate: ThreadWatcherDelegate? { get set }
    func start()
    func stop()
}
