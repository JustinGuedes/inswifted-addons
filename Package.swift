// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "InSwifted-Addons",
    platforms: [
        .iOS(.v14), .macOS(.v11)
    ],
    products: [
        .library(
            name: "InModules",
            targets: ["InModules"]),
        .library(
            name: "InTabs",
            targets: ["InTabs"])
    ],
    dependencies: [
        .package(url: "https://github.com/JustinGuedes/inswifted.git", .upToNextMajor(from: "0.1.0")),
        .package(url: "https://github.com/JustinGuedes/prelude.git", .upToNextMinor(from: "0.0.1"))
    ],
    targets: [
        .target(
            name: "InModules",
            dependencies: [
                .product(name: "InSwifted", package: "inswifted")
            ]),
        .testTarget(
            name: "InModulesTests",
            dependencies: ["InModules"]),
        .target(
            name: "InTabs",
            dependencies: [
                .product(name: "InSwifted", package: "inswifted"),
                .product(name: "Prelude", package: "prelude")
            ]),
        .testTarget(
            name: "InTabsTests",
            dependencies: ["InTabs"]),
    ]
)
