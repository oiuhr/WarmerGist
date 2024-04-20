//
//  Target+Build.swift
//  Warmer
//
//  Copyright © 2023 oiu. All rights reserved.
//

import ProjectDescription

public extension Target {
    static var buildTargets: [Target] {
        [.appTarget]
    }
}

private extension Target {
    static var appTarget: Target {
        .target(
            name: Constants.appName,
            destinations: .iOS,
            product: .app,
            bundleId: Constants.bundleId,
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": .dictionary([
                        "UIColorName": "BackgroundColor",
                    ])
                ]
            ),
            sources: .paths([.relativeToRoot("Sources/Warmer/App/**")]),
            resources: resources,
            dependencies: [
                .package(product: "WarmerUI"),
                .package(product: "WarmerCore"),
                .package(product: "FeatureA"),
                .package(product: "FeatureB"),
            ]
        )
    }
    
    static var resources: ResourceFileElements {
        return .resources([
            "Sources/Warmer/Resources/**",
        ])
    }
}
