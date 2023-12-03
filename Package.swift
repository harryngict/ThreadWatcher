// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "ThreadWatcher",
    platforms: [
        .iOS(.v12),
    ],
    products: [
        .library(
            name: "ThreadWatcher",
            targets: ["ThreadWatcher"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ThreadWatcher",
            path: "Sources/ThreadWatcher"
        ),
        .testTarget(
            name: "ThreadWatcherTests",
            dependencies: ["ThreadWatcher"],
            path: "Tests/ThreadWatcherTests"
        ),
    ]
)
