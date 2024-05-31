package_name = 'WarmerDependencies'
executable_dependency_template = '\n                .target(name: "{name}"),'
binary_target_template = '''
        .binaryTarget(
            name: "{name}",
            path: "{path}"
        ),'''
manifest_template = '''// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "{package_name}",
    platforms: [.iOS("15.0")],
    products: [
        .library(
            name: "{package_name}",
            targets: [
                "{package_name}",
            ]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "{package_name}",
            dependencies: [{executable_dependencies}
            ]
        ),{binary_targets}
    ]
)'''