// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StadiaMapsMapKit",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .visionOS(.v1),
        .watchOS(.v6),
        .tvOS(.v13),
        .macCatalyst(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "StadiaMapsMapKit",
            targets: ["StadiaMapsMapKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/stadiamaps/mapkit-caching-tile-overlay", from: "1.0.2")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "StadiaMapsMapKit",
            dependencies: [.product(name: "CachingMapKitTileOverlay", package: "mapkit-caching-tile-overlay")]),
        .testTarget(
            name: "StadiaMapsMapKitTests",
            dependencies: ["StadiaMapsMapKit"]
        ),
    ]
)
