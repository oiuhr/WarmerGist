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
        .package(path: "../WarmerDependencies"),
    ],
    targets: [
        .target(
            name: "WarmerUI",
            dependencies: [
                "WarmerDependencies"
            ]
        ),
    ]
)
