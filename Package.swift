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
      // url: "https://localhost:4433/swiftgen-disk-6.5.1.zip",
      // checksum: "2ad7b014899e6fb9f09b32544549703e6f59d40f91248d9c2dfd880045010339"
      url: "https://localhost:4433/swiftgen-subdir-6.5.1.zip",
      checksum: "312b986c0be7e13c7411fd4a0baa11c9fa7bf75a796d7cd373b67a4d7ec021ae"
    )
  ]
)
