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
      checksum: "b308b0250e7111b10f3ce5ef2d79bc200212809e67cbc8c3f8407539775430a8"
    ),
    // .binaryTarget(
    //   name: "rswift",
    //   url: "https://localhost:4433/rswift-v6.1.0.zip",
    //   checksum: "8a61de2954038023863b5eed2853e2bde8e6d7f73baa96b62334fa887a8690ae"
    // )
  ]
)
