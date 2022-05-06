// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "swiftgen-plugin",
  products: [
    .plugin(name: "SwiftGenPlugin", targets: ["SwiftGenPlugin"])
  ],
  dependencies: [],
  targets: [
    .plugin(
      name: "SwiftGenPlugin",
      capability: .command(
        intent: .custom(
          verb: "Run swiftgen",
          description: "Generates Swift code for target's resources"
        ),
        permissions: [
          .writeToPackageDirectory(reason: "SwiftGen generates code with resource accessors")
        ]
      ),
      dependencies: ["rswift"]
    ),
    .binaryTarget(
      name: "swiftgen",
      url: "https://localhost:4433/swiftgen-v6.5.1.zip",
      checksum: "1cde240d8a1cb7a3656329991fcd4f16113171dde45024cc2ade37d412bca876"
    ),
    .binaryTarget(
      name: "rswift",
      url: "https://localhost:4433/rswift-v6.1.0.zip",
      checksum: "8a61de2954038023863b5eed2853e2bde8e6d7f73baa96b62334fa887a8690ae"
    )
  ]
)
