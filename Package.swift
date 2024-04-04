// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DDS",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "DDS",
            targets: ["DDS"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "DDS",
            dependencies: [],
            resources: [
                .process("Foundation/Typography/Font")
            ]
        )
    ]
)
