import PackageDescription

let package = Package(
    name: "PropellerKit",
    exclude: ["Tests"],
    dependencies: [
        .Package(url: "https://github.com/propellerlabs/PropellerNetwork.git", majorVersion: 1),
        .Package(url: "https://github.com/propellerlabs/PropellerPromise.git", majorVersion: 1)
    ]
)
