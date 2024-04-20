// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import WarmerUI
import WarmerCore

public struct FeatureAContentView: View {
    
    public init() {}
    
    public var body: some View {
        Button {
            Task {
                await WarmerCore.call()
                WarmerUI.alert(for: "Dispatched")
            }
        } label: {
            Text("Dispatch")
        }
    }
}
