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
      dependencies: ["swiftgen"]
    ),
    .binaryTarget(
      name: "swiftgen",
      url: "https://localhost:4433/swiftgen.artifactbundle.zip",
      checksum: "655391fe7c9dfc239f04c0b2df9b30ccd73d7d6c53ff3a6aa35bf5ad3c5c3911"
    ),
    // .binaryTarget(
    //   name: "rswift",
    //   url: "https://localhost:4433/rswift-v6.1.0.zip",
    //   checksum: "8a61de2954038023863b5eed2853e2bde8e6d7f73baa96b62334fa887a8690ae"
    // )
  ]
)
