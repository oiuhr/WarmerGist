// swift-tools-version: 5.9

import PackageDescription

// Common project UI
let package = Package(
    name: "WarmerUI",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "WarmerUI",
            targets: ["WarmerUI"]
        ),
    ],
    dependencies: [
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
            name: "WarmerUI",
            dependencies: [
                "SwiftMessages",
                .product(name: "Lottie", package: "lottie-ios"),
            ]
        ),
    ]
)
