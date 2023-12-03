//
//  ThreadWatcher.swift
//  ThreadWatcher
//
//  Created by Hoang Nguyen on 3/12/23.
//

import Foundation

public final class ThreadWatcher: ThreadWatcherInterface {
    public weak var delegate: ThreadWatcherDelegate?
    private let serialQueue = DispatchQueue(label: "com.ThreadWatcher.queue")
    private var state: ThreadWatcherState = .stopped
    private var startTime: StartTimeState = .notStarted
    private let threshold: TimeInterval

    public init(threshold: TimeInterval) {
        self.threshold = threshold
    }

    private lazy var mainRunLoop: CFRunLoop = CFRunLoopGetMain()

    private lazy var mainRunLoopObserver: CFRunLoopObserver = CFRunLoopObserverCreateWithHandler(
        kCFAllocatorDefault,
        CFRunLoopActivity.allActivities.rawValue,
        true,
        .min
    ) { _, activity in
        self.handleRunLoopActivity(activity)
    }

    public func start() {
        guard case .stopped = state else { return }
        state = .started
        resetStartTime()
        CFRunLoopAddObserver(mainRunLoop, mainRunLoopObserver, CFRunLoopMode.commonModes)
        startObservation(after: threshold)
    }

    public func stop() {
        guard case .started = state else { return }
        state = .stopped
        resetStartTime()
        CFRunLoopRemoveObserver(mainRunLoop, mainRunLoopObserver, CFRunLoopMode.commonModes)
    }

    private enum ThreadWatcherState {
        case started
        case stopped
    }

    private enum StartTimeState {
        case notStarted
        case started(TimeInterval)
    }
}

private extension ThreadWatcher {
    func handleRunLoopActivity(_ activity: CFRunLoopActivity) {
        serialQueue.async {
            switch activity {
            case .entry, .beforeTimers, .afterWaiting, .beforeSources:
                self.serialQueue.async {
                    if case .notStarted = self.startTime {
                        self.startTime = .started(Date().timeIntervalSince1970)
                    }
                }
            case .beforeWaiting, .exit:
                self.serialQueue.async {
                    self.startTime = .notStarted
                }
            default:
                break
            }
        }
    }

    func resetStartTime() {
        serialQueue.async {
            self.startTime = .notStarted
        }
    }

    func startObservation(after interval: TimeInterval) {
        guard case .started = state else { return }

        serialQueue.asyncAfter(deadline: .now() + interval) { [weak self] in
            guard let self, case let .started(start) = self.startTime else {
                self?.startObservation(after: self?.threshold ?? 0.0)
                return
            }
            let endTime = Date().timeIntervalSince1970
            let duration = endTime - start
            if duration >= self.threshold {
                self.delegate?.hangoutOccurred(self, withDuration: duration)
                self.stop()
            } else {
                self.startObservation(after: self.threshold - duration)
            }
        }
    }
}
