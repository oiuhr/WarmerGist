// swift-tools-version: 5.9

import PackageDescription

// Core — network, common project logic, etc.
let package = Package(
    name: "WarmerCore",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "WarmerCore",
            targets: ["WarmerCore"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-async-algorithms.git",
            exact: "1.0.0"
        ),
        .package(
            url: "https://github.com/Alamofire/Alamofire.git",
            exact: "5.9.1"
        ),
    ],
    targets: [
        .target(
            name: "WarmerCore",
            dependencies: [
                "Alamofire",
                .product(name: "AsyncAlgorithms", package: "swift-async-algorithms"),
            ]
        ),
    ]
)
