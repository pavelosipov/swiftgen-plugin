# SwiftGen Plugin
Plugin integrates SwiftGen with multitarget packages. Unlinke [official example](https://github.com/apple/swift-evolution/blob/main/proposals/0303-swiftpm-extensible-build-tools.md#example-1-swiftgen) it assumes each target has its own resources and swiftgen config.

## Usage
Here is an example of the package which contains separate targets for the app features.

```swift
// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Features",
  platforms: [.iOS(.v15)],
  products: [
    .library(name: "Fizz", targets: ["Fizz"]),
    .library(name: "Buzz", targets: ["Buzz"])
  ],
  dependencies: [
    .package(
      url: "https://github.com/pavelosipov/swiftgen-plugin.git",
      from: "1.0.0"
    ),
  ],
  targets: [
    .target(
      name: "Fizz",
      exclude: ["swiftgen.yml"],
      resources: [.process("Resources")],
      dependencies: ["CommonResources"],
      plugins: [
        .plugin(name: "SwiftGenPlugin", package: "swiftgen-plugin")
      ]
    ),
    .target(
      name: "Buzz",
      exclude: ["swiftgen.yml"],
      resources: [.process("Resources")],
      dependencies: ["CommonResources"],
      plugins: [
        .plugin(name: "SwiftGenPlugin", package: "swiftgen-plugin")
      ]
    ),
    .target(
      name: "CommonResources",
      exclude: ["swiftgen.yml"],
      resources: [.process("Resources")],
      plugins: [
        .plugin(name: "SwiftGenPlugin", package: "swiftgen-plugin")
      ]
    )
  ]
)
```

Plugin follows Swift Package Manager convention over configuration paradigm. Its assumptions are the following:
- Target locates its resources in the "Resources" subdirectory.
- Each swiftgen config has configured `input_dir` and `output_dir` fields with environment fields `INPUT_DIR` and `OUTPUT_DIR` correspondingly. Below is the example of swiftgen config.
  ```
  input_dir: ${INPUT_DIR}
  output_dir: ${OUTPUT_DIR}
  xcassets:
    inputs:
      - Assets.xcassets
    outputs:
      - templateName: swift5
        output: Assets.swift
  ```

