// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Convert",
    platforms: [
        .macOS(.v15),
    ],
    products: [
        .library(name: "ConvertCore", targets: ["ConvertCore"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.6.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ConvertCore",
            dependencies: []
        ),
        .testTarget(
            name: "ConvertCoreTests",
            dependencies: ["ConvertCore"]
        ),
        .executableTarget(
            name: "Convert",
            dependencies: [
                "ConvertCore",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]
        ),
    ]
)
