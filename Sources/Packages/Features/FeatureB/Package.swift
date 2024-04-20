// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "FeatureB",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "FeatureB",
            targets: ["FeatureB"]
        ),
    ],
    dependencies: [
        .package(path: "../Common/WarmerUI"),
        .package(path: "../Common/WarmerCore"),
    ],
    targets: [
        .target(
            name: "FeatureB",
            dependencies: [
                "WarmerUI",
                "WarmerCore"
            ]
        ),
    ]
)
