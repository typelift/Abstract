// swift-tools-version:4.0

import Foundation
import PackageDescription

// HACK from https://github.com/ReactiveCocoa/ReactiveSwift/blob/master/Package.swift
var isSwiftPMTest: Bool {
    return ProcessInfo.processInfo.environment["SWIFTPM_TEST_Abstract"] == "YES"
}

let package = Package(
    name: "Abstract",
    dependencies: [
        .package(url: "https://github.com/typelift/Operadics.git",
                 from: Version(0,0,0))
    ] + (isSwiftPMTest ? [.package(url: "https://github.com/typelift/SwiftCheck.git",
                                   Version(0,6,0)..<Version(1,0,0))] 
                       : [])
)

