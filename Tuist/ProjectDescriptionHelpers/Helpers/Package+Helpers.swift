//
//  Package+Sugar.swift
//  Warmer
//
//  Copyright © 2023 oiu. All rights reserved.
//

import ProjectDescription

public extension Package {
    static func featurePackage(name: String) -> Self {
        .package(path: "Sources/Packages/Features/\(name)")
    }
    
    static func commonPackage(name: String) -> Self {
        .package(path: "Sources/Packages/Common/\(name)")
    }
}

public extension Package {
    static var localPackages: [Package] {
        [
            .featurePackage(name: "FeatureA"),
            .featurePackage(name: "FeatureB"),
            .commonPackage(name: "WarmerCore"),
            .commonPackage(name: "WarmerUI"),
        ]
    }
}
