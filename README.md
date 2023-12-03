# ThreadWatcher

`ThreadWatcher` is a Swift class designed to monitor the activity on the main thread's run loop and detect hangs or delays that exceed a specified threshold. It provides a simple interface to start and stop the observation, and it notifies a delegate when a hang is detected.

## Features

- **Thread Monitoring:** Observes the main thread's run loop for various activities.
- **Threshold Detection:** Notifies the delegate when the thread hangs for a duration exceeding a specified threshold.
- **Start and Stop:** Easily start and stop the observation.

## Integration through CocoaPods

To integrate NetworkCompose into your Xcode project using CocoaPods, add the following to your `Podfile`:

```ruby
pod 'ThreadWatcher'
```

then run:
```bash
pod install
```
###  Integration through Swift Package Manager (SPM)
To integrate NetworkCompose using Swift Package Manager, add the following to your Package.swift file:
```swift
dependencies: [
    .package(url: "https://github.com/harryngict/ThreadWatcher.git", from: "0.0.1")
],
targets: [
    .target(
        name: "YourTargetName",
        dependencies: ["ThreadWatcher"]
    )
]
```
Replace "YourTargetName" with the name of your target. Then, run:
```bash
swift package update
```

## Usage

### Initialization

```swift
// Create a ThreadWatcher instance with a specified threshold
let threadWatcher = ThreadWatcher(threshold: 5.0) // Set your desired threshold in seconds
threadWatcher.delegate = self // Conform to ThreadWatcherDelegate to receive notifications
```
### Starting and Stopping Observation

```swift
// Start thread observation
threadWatcher.start()

// Stop thread observation
threadWatcher.stop()
```swift

### Handling Delegates
Implement the ThreadWatcherDelegate protocol to receive notifications when a hang is detected.
```swift
class MyThreadWatcherDelegate: ThreadWatcherDelegate {
    func hangoutOccurred(_ threadWatcher: ThreadWatcher, withDuration duration: TimeInterval) {
        print("Hangout detected on the main thread. Duration: \(duration) seconds")
    }
}

// Assign the delegate to the thread watcher
let myDelegate = MyThreadWatcherDelegate()
threadWatcher.delegate = myDelegate
```

### Example
```swift
class MyViewController: UIViewController, ThreadWatcherDelegate {
    private var threadWatcher: ThreadWatcher!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create and configure ThreadWatcher
        threadWatcher = ThreadWatcher(threshold: 5.0)
        threadWatcher.delegate = self

        // Start thread observation
        threadWatcher.start()
    }

    // Implement ThreadWatcherDelegate methods here
    func hangoutOccurred(_ threadWatcher: ThreadWatcher, withDuration duration: TimeInterval) {
        print("Hangout detected on the main thread. Duration: \(duration) seconds")
    }
}
```

