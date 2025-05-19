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
        .package(url: "https://github.com/apple/swift-openapi-generator", from: "1.6.0"),
        .package(url: "https://github.com/apple/swift-openapi-runtime", from: "1.7.0"),
        .package(url: "https://github.com/swift-server/swift-openapi-vapor", from: "1.0.0"),
        .package(
            url: "https://github.com/pilgrimagesoftware/horology-core.swift.git", from: "0.0.20"),
        .package(url: "https://github.com/apple/swift-metrics", from: "2.4.1"),
        .package(url: "https://github.com/swift-server/swift-prometheus", from: "2.0.0"),
        .package(url: "https://github.com/apple/swift-distributed-tracing", from: "1.0.1"),
        .package(
            url: "https://github.com/apple/swift-distributed-tracing-extras", exact: "1.0.0-beta.1"),
        .package(url: "https://github.com/swift-otel/swift-otel", .upToNextMinor(from: "0.11.0")),
        .package(url: "https://github.com/apple/swift-http-types", from: "1.0.2"),
        .package(url: "https://github.com/apple/swift-log", from: "1.5.3"),
    ],
    targets: [
        .target(
            name: "MetricsMiddleware",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "Metrics", package: "swift-metrics"),
            ]
        ),
        .target(
            name: "TracingMiddleware",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "Tracing", package: "swift-distributed-tracing"),
                .product(
                    name: "TracingOpenTelemetrySemanticConventions",
                    package: "swift-distributed-tracing-extras"),
            ]
        ),
        .target(
            name: "LoggingMiddleware",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "HTTPTypes", package: "swift-http-types"),
                .product(name: "Logging", package: "swift-log"),
            ]
        ),
        .executableTarget(
            name: "HorologyAPI",
            dependencies: [
                "MetricsMiddleware",
                "TracingMiddleware",
                "LoggingMiddleware",
                .product(name: "Leaf", package: "leaf"),
                .product(name: "Vapor", package: "vapor"),
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio"),
                .product(name: "HorologyCore", package: "horology-core.swift"),
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIVapor", package: "swift-openapi-vapor"),
                .product(name: "Prometheus", package: "swift-prometheus"),
                .product(name: "OTel", package: "swift-otel"),
                .product(name: "OTLPGRPC", package: "swift-otel"),
            ],
            swiftSettings: swiftSettings,
            plugins: [
                .plugin(name: "OpenAPIGenerator", package: "swift-openapi-generator")
            ]
        ),
        .testTarget(
            name: "HorologyAPITests",
            dependencies: [
                "LoggingMiddleware",
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
