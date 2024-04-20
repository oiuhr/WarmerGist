//
//  SettingsDictionary+Sugar.swift
//  Warmer
//
//  Copyright © 2023 oiu. All rights reserved.
//

import Foundation
import ProjectDescription

// MARK: - Dictionary + String && ProjectDescription.SettingValue

public extension Dictionary where Key == String, Value == ProjectDescription.SettingValue {

    // MARK: - Functions

    /// Sets `"IPHONEOS_DEPLOYMENT_TARGET"` to given `target`.
    func deploymentTargetForIos(_ target: Double) -> ProjectDescription.SettingsDictionary {
        rewrite(.string("\(target)"), for: "IPHONEOS_DEPLOYMENT_TARGET")
    }
}

// MARK: - Dictionary + String && ProjectDescription.SettingValue

private extension Dictionary where Key == String, Value == ProjectDescription.SettingValue {
    func rewrite(_ value: Value, for key: Key) -> SettingsDictionary {
        var copy = self
        copy.updateValue(value, forKey: key)

        return copy
    }
}
