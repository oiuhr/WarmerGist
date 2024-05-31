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
        .package(path: "../WarmerDependencies"),
    ],
    targets: [
        .target(
            name: "WarmerCore",
            dependencies: [
                "WarmerDependencies"
            ]
        ),
    ]
)
