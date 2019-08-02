// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftQL",
    platforms: [.macOS(.v10_12)],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax.git", .exact("0.50000.0")),
    ],
    targets: [
        .target(name: "App", dependencies: ["SwiftQL"]),
        .target(name: "SwiftQL", dependencies: ["SwiftSyntax"]),
    ]
)
