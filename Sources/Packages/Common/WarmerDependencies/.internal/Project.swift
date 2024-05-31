//
//  Project.swift
//  WarmerDemo
//
//  Copyright © 2024 oiu. All rights reserved.
//

import ProjectDescription

let project = Project(
    name: "_WarmerDependencies",
    options: .options(
        automaticSchemesOptions: .disabled,
        disableBundleAccessors: true,
        disableSynthesizedResourceAccessors: true
    ),
    settings: .settings(
        base: SettingsDictionary()
            .codeSignIdentityAppleDevelopment()
    ),
    targets: [
        .target(
            name: "_WarmerDependencies",
            destinations: .iOS,
            product: .app,
            bundleId: "ru.oiu.warmer.demo.dependencies.framework",
            deploymentTargets: .iOS("15.0"),
            dependencies: [
                .external(name: "Alamofire"),
                .external(name: "AsyncAlgorithms"),
                .external(name: "Lottie"),
                .external(name: "SwiftMessages"),
            ]
        ),
    ]
)
