// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "M3U",
    platforms: [.macOS(.v10_15), .iOS(.v13), .watchOS(.v6), .tvOS(.v13)],
    products: [
        .library(name: "M3U", targets: ["M3U"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-collections.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.5.0")),
    ],
    targets: [
        .target(name: "M3U", dependencies: [
            .product(name: "OrderedCollections", package: "swift-collections"),
        ]),
        .testTarget(name: "M3UTests", dependencies: ["M3U", "Alamofire",]),
    ]
)
