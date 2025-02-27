// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Rocket",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .executable(
            name: "rocket",
            targets: ["Rocket"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/jpsim/Yams", from: "4.0.0"),
        .package(url: "https://github.com/shibapm/Logger", from: "0.2.2"),
        .package(url: "https://github.com/kareman/SwiftShell", .exact("5.1.0-beta.1")),
        .package(url: "https://github.com/shibapm/PackageConfig.git", from: "1.0.0"),
        // Dev Dependencies for testing.setup
        .package(url: "https://github.com/Quick/Nimble", from: "8.0.0"), // dev
        .package(url: "https://github.com/f-meloni/TestSpy", from: "0.3.1"), // dev
        // .package(url: "https://github.com/shibapm/Komondor.git", from: "1.0.0"), // dev
        .package(url: "https://github.com/nicklockwood/SwiftFormat.git", from: "0.35.8"), // dev
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "RocketLib",
            dependencies: ["Logger", "SwiftShell"]
        ),
        .target(
            name: "Rocket",
            dependencies: ["Yams", "Logger", "PackageConfig", "RocketLib"]
        ),
        .testTarget(name: "RocketTests", dependencies: ["RocketLib", "Nimble", "TestSpy"]), // dev
    ]
)

#if canImport(PackageConfig)
    import PackageConfig

    let config = PackageConfiguration([
        "komondor": [
            "pre-commit": [
                "swift run swiftformat .",
                "git add .",
            ],
        ],
    ]).write()
#endif
