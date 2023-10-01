// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FeedbackSender",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "FeedbackSender", targets: ["FeedbackSender"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "FeedbackSender", dependencies: [])
    ]
)
