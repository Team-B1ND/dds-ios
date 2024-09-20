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
        .package(url: "https://github.com/lorenzofiamingo/swiftui-cached-async-image", from: "2.1.1")
    ],
    targets: [
        .target(
            name: "DDS",
            dependencies: [
                .product(name: "CachedAsyncImage", package: "swiftui-cached-async-image")
            ],
            resources: [
                .process("Foundation/Typography/Font"),
                .process("Foundation/Iconography/Iconography.xcassets")
            ]
        )
    ]
)
