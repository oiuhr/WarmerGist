// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "WarmerDependencies",
    platforms: [.iOS("15.0")],
    products: [
        .library(
            name: "WarmerDependencies",
            targets: [
                "WarmerDependencies",
            ]
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
        .package(
            url: "https://github.com/airbnb/lottie-ios.git",
            exact: "4.4.3"
        ),
        .package(
            url: "https://github.com/SwiftKickMobile/SwiftMessages.git",
            exact: "10.0.0"
        ),
    ],
    targets: [
        .target(
            name: "WarmerDependencies",
            dependencies: [
                "SwiftMessages",
                .product(name: "Lottie", package: "lottie-ios"),
                "Alamofire",
                .product(name: "AsyncAlgorithms", package: "swift-async-algorithms"),
            ]
        ),
    ]
)
