// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Coffee",
    platforms: [.macOS(.v13)],
    targets: [
        .executableTarget(
            name: "Coffee",
            path: "Sources/Coffee",
            exclude: ["Info.plist"]
        )
    ]
)
