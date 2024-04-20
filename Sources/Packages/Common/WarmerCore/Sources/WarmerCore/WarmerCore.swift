// The Swift Programming Language
// https://docs.swift.org/swift-book

import Alamofire

public enum WarmerCore {
    
    public static func call() async {
        _ = Alamofire.Session.default
        try? await Task.sleep(nanoseconds: 3_000_000_000)
    }
}
