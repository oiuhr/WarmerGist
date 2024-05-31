// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
// Xcode: 15.1

import PackageDescription

#if TUIST
    import ProjectDescription

    let packageSettings = PackageSettings(
        productTypes: [:],
        targetSettings: [:]
    )
#endif

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
//             exact: "5.9.1"
            exact: "5.9.0"
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
                "Alamofire",
                "SwiftMessages",
                .product(name: "AsyncAlgorithms", package: "swift-async-algorithms"),
                .product(name: "Lottie", package: "lottie-ios"),
            ]
        ),
    ]
)
