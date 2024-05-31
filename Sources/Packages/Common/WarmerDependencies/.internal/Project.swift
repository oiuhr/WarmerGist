//
//  Project.swift
//  WarmerDemo
//
//  Copyright © 2024 oiu. All rights reserved.
//

import ProjectDescription

// Скрипт, копирующий *.bundle директории из DD в директирию кеша.
let script = """
find $BUILT_PRODUCTS_DIR -maxdepth 1 -type d -name '*.bundle' -execdir cp -R "{}" $CACHED_BUNDLES_DIRECTORY ";"
"""

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
        // Схема для генерации *.bundle директорий для статических фреймворков.
        // Отдельно чтобы не билдить все остальное.
        .target(
            name: "_BundleDummy",
            destinations: .iOS,
            product: .app,
            bundleId: "ru.oiu.warmer.demo.dependencies.bundles",
            deploymentTargets: .iOS("15.0"),
            dependencies: [
                .external(name: "Lottie"),
            ]
        ),
    ],
    schemes: [
        .scheme(
            name: "Bundles",
            buildAction: .buildAction(
                targets: [
                    .target("_BundleDummy"),
                ],
                postActions: [
                    .executionAction(
                        title: "Copy *.bundle`s to external folder",
                        scriptText: script,
                        target: .target("_BundleDummy")
                    ),
                ]
            )
        ),
    ]
)
