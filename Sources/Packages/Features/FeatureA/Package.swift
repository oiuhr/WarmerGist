// swift-tools-version: 5.9

import PackageDescription

// Example feature module
let package = Package(
    name: "FeatureA",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "FeatureA",
            targets: ["FeatureA"]
        ),
    ],
    dependencies: [
        .package(path: "../Common/WarmerUI"),
        .package(path: "../Common/WarmerCore"),
    ],
    targets: [
        .target(
            name: "FeatureA",
            dependencies: [
                "WarmerUI",
                "WarmerCore"
            ]
        ),
    ]
)
