# SwiftGen Plugin
Plugin integrates SwiftGen with multitarget packages. Unlike [official example](https://github.com/apple/swift-evolution/blob/main/proposals/0303-swiftpm-extensible-build-tools.md#example-1-swiftgen), it assumes each target has its own resources and swiftgen config.

> **_NOTE:_**  There is a companion repository [swiftgen-plugin-demo](https://github.com/pavelosipov/swiftgen-plugin-demo) where you can look at the usage details.

## Usage
Here is an example of the package which contains separate targets for the app features.

```swift
// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Packages",
  defaultLocalization: "en",
  platforms: [.iOS(.v15)],
  products: [
    .library(name: "Fizz", targets: ["Fizz"]),
    .library(name: "Buzz", targets: ["Buzz"])
  ],
  dependencies: [
    .package(
      url: "https://github.com/pavelosipov/swiftgen-plugin",
      version: "1.0.0"
    ),
  ],
  targets: [
    .target(
      name: "Fizz",
      dependencies: ["SharedResources"],
      exclude: ["Resources/swiftgen.yml"],
      resources: [.process("Resources")],
      plugins: [
        .plugin(name: "SwiftGenPlugin", package: "SwiftGenPlugin")
      ]
    ),
    .target(
      name: "Buzz",
      dependencies: ["SharedResources"],
      exclude: ["Resources/swiftgen.yml"],
      resources: [.process("Resources")],
      plugins: [
        .plugin(name: "SwiftGenPlugin", package: "SwiftGenPlugin")
      ]
    ),
    .target(
      name: "SharedResources",
      exclude: ["Resources/swiftgen.yml"],
      resources: [.process("Resources")],
      plugins: [
        .plugin(name: "SwiftGenPlugin", package: "SwiftGenPlugin")
      ]
    )
  ]
)
```

Plugin follows Swift Package Manager paradigm convention over configuration. Assumptions are the following:
- Target locates all its resources in the "Resources" subdirectory. SPM wants the same, so no surprises here.
- Target locates `swiftgen.yml` config in the "Resources" subdirectory. The reason is to help SPM realize that there are resources there in some very practical case. When that directory contains only XX.lproj subdirectories with localized version of some files (`Localizable.strings` for example) then SPM thinks that target doesn't contain resources at all and refuses to generate `resource_bundle_accessor.swift` file which contains extension to `Foundation.Bundle` class used by SwiftGen generated code.
- Each swiftgen config has configured `input_dir` and `output_dir` properties filled with environment variables `INPUT_DIR` and `OUTPUT_DIR` correspondingly. They will be prepared by SwiftGen plugin.
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

## Caveats
Here are several SPM issued I have faced with during plugin development.

1. It is impossible to use plugin as local dependencies. I wasted 2 hours trying to figure out why the plugin doesn't work in conjunction with my [demo app](https://github.com/pavelosipov/swiftgen-plugin-demo). Bug [SR-14343](https://bugs.swift.org/browse/SR-14343) already [fixed](https://github.com/apple/swift-package-manager/pull/3623) in swift main branch and will be shipped with Swift 5.7.
2. Even when the bug mentioned above will be fixed, there is another blocker for local plugins. You can read about it in the thread [Xcode attempts to build plugins for iOS](https://forums.swift.org/t/xcode-attempts-to-build-plugins-for-ios-is-there-a-workaround/57029) on the Swift forum. So the separate repository is the only true way for plugin development right now.

## License
Copyright (c) 2022 Pavel Osipov

Licensed under the MIT license, http://www.opensource.org/licenses/mit-license.php
