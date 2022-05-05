import Foundation
import PackagePlugin

@main
struct SwiftGenPlugin: BuildToolPlugin {
  func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
    let swiftgenConfig = try SwiftGenCommandConfig.make(for: context, target: target)
    dump(swiftgenConfig)
    try FileManager.default.createDirectory(
      atPath: swiftgenConfig.outputFilesPath.string,
      withIntermediateDirectories: true
    )
    return [.swiftgenCommand(for: swiftgenConfig)]
  }
}

// MARK: -

struct SwiftGenCommandConfig {
  var toolPath: Path
  var configPath: Path
  var inputFilesPath: Path
  var outputFilesPath: Path
  var environment: [String : CustomStringConvertible]
}

extension SwiftGenCommandConfig {
  static func make(for context: PluginContext, target: Target) throws -> Self {
    .init(
      toolPath: try context.tool(named: "swiftgen").path,
      inputFilesPath: target.directory.appending("Resources"),
      outputFilesPath: context.pluginWorkDirectory.appending("Generated")
    )
  }

  init(toolPath: Path, inputFilesPath: Path, outputFilesPath: Path) {
    self.init(
      toolPath: toolPath,
      configPath: inputFilesPath.appending("swiftgen.yml"),
      inputFilesPath: inputFilesPath,
      outputFilesPath: outputFilesPath,
      environment: [
        "INPUT_DIR": inputFilesPath,
        "OUTPUT_DIR": outputFilesPath,
      ]
    )
  }
}

// MARK: -

extension Command {
  static func swiftgenCommand(for swiftgen: SwiftGenCommandConfig) -> Command {
    .prebuildCommand(
      displayName: "Running SwiftGen",
      executable: swiftgen.toolPath,
      arguments: ["config", "run", "--verbose", "--config", swiftgen.configPath],
      environment: swiftgen.environment,
      outputFilesDirectory: swiftgen.outputFilesPath
    )
  }
}
