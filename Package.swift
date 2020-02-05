// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Cely",
    platforms: [
        .iOS(.v11),
    ],
    products: [
        .library(
            name: "Cely",
            targets: ["Cely"]),
    ],
    targets: [
        .target(
            name: "Cely",
            path: "Sources"),
    ]
)
