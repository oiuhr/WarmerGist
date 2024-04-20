//
//  Project.swift
//  Warmer
//
//  Copyright © 2024 oiu. All rights reserved.
//

import ProjectDescription
import ProjectDescriptionHelpers

let baseSettings: SettingsDictionary = .init()
    .deploymentTargetForIos(15.0)
    .codeSignIdentityAppleDevelopment()

let project = Project(
    name: Constants.projectName,
    options: .options(
        disableBundleAccessors: true,
        disableSynthesizedResourceAccessors: true
    ),
    packages: Package.localPackages,
    settings: Settings.settings(
        base: baseSettings,
        debug: .init(),
        release: .init()
    ),
    targets: Target.buildTargets
)
