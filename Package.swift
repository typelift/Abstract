// swift-tools-version:4.0

import Foundation
import PackageDescription

let package = Package(
	name: "Abstract",
	products: [
		.library(
			name: "Abstract",
			targets: ["Abstract"])
	],
	dependencies: [
		.package(url: "https://github.com/typelift/Operadics.git",
		         from: Version(0,0,0)),
		.package(url: "https://github.com/typelift/SwiftCheck.git",
		         from: Version(0,6,0))
	],
	targets: [
		.target(
			name: "Abstract",
			dependencies: ["Operadics"]),
		.testTarget(
			name: "AbstractTests",
			dependencies: ["Abstract","SwiftCheck"])
	]
)
