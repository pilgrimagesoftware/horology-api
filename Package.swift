// swift-tools-version:6.1
//
//  Horology API
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "HorologyAPI",
    platforms: [
        .macOS(.v13)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.110.1"),
        // 🍃 An expressive, performant, and extensible templating language built for Swift.
        .package(url: "https://github.com/vapor/leaf.git", from: "4.3.0"),
        // 🔵 Non-blocking, event-driven networking for Swift. Used for custom executors
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.65.0"),
        .package(
            url: "https://github.com/pilgrimagesoftware/horology-core.swift.git", from: "0.0.15"),
    ],
    targets: [
        .executableTarget(
            name: "HorologyAPI",
            dependencies: [
                .product(name: "Leaf", package: "leaf"),
                .product(name: "Vapor", package: "vapor"),
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio"),
                .product(name: "HorologyCore", package: "horology-core.swift"),
            ],
            swiftSettings: swiftSettings
        ),
        .testTarget(
            name: "HorologyAPITests",
            dependencies: [
                .target(name: "HorologyAPI"),
                .product(name: "VaporTesting", package: "vapor"),
            ],
            swiftSettings: swiftSettings
        ),
    ]
)

var swiftSettings: [SwiftSetting] {
    [
        .enableUpcomingFeature("ExistentialAny"),
        .swiftLanguageMode(.v5),
    ]
}
