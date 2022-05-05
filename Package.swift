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
      url: "https://getfile.dokpub.com/yandex/get/https://disk.yandex.ru/d/cn5hbs0PRBLozg",
      // url: "https://github.com/nicorichard/SwiftGen/releases/download/6.5.1/swiftgen-6.5.1.zip",
      checksum: "c5e7d24292a4f21f710f9a8c82f45559930a2a323c4fddd486ed453b11be0dc1"
    )
  ]
)
