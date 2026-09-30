// swift-tools-version: 6.0

import Foundation
import PackageDescription

let package = Package(
    name: "swift-data-parsing",
    platforms: [.macOS(.v10_13), .iOS(.v12), .tvOS(.v12), .watchOS(.v4)],
    products: [
        .library(
            name: "SwiftDataParsing",
            targets: ["SwiftDataParsing"]
        )
    ],
    dependencies: [
        // none
    ],
    targets: [
        .target(
            name: "SwiftDataParsing",
            dependencies: [],
            swiftSettings: [.define("DEBUG", .when(configuration: .debug))]
        ),
        .testTarget(
            name: "SwiftDataParsingTests",
            dependencies: ["SwiftDataParsing"]
        )
    ]
)

// MARK: - Utilities

func hasEnvironmentVariable(_ name: String) -> Bool {
    ProcessInfo.processInfo.environment[name] != nil
}

// MARK: - CI Pipeline

if hasEnvironmentVariable("GITHUB_ACTIONS") {
    for target in package.targets {
        if target.swiftSettings == nil { target.swiftSettings = [] }
        target.swiftSettings? += [.define("GITHUB_ACTIONS", .when(configuration: .debug))]
    }
}
