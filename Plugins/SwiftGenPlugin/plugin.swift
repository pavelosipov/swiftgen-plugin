import Foundation
import PackagePlugin

@main
struct SwiftGenPlugin: BuildToolPlugin {
  func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
    let swiftgenPath = try context.tool(named: "swiftgen").path
    let configPath = target.directory.appending("swiftgen.yml")
    let inputFilesDirectory = target.directory.appending("Resources")
    let outputFilesDirectory = context.pluginWorkDirectory.appending("Generated")
    try FileManager.default.createDirectory(
      atPath: outputFilesDirectory.string,
      withIntermediateDirectories: true
    )
    let environment = [
      "INPUT_DIR": inputFilesDirectory.string,
      "OUTPUT_DIR": outputFilesDirectory.string,
    ]
    print("swiftgenPath:", swiftgenPath)
    print("configPath:", configPath)
    print("environment:", environment)
    return [
      .prebuildCommand(
        displayName: "Running SwiftGen",
        executable: swiftgenPath,
        arguments: [
          "config",
          "run",
          "--verbose",
          "--config",
          "\(configPath)"
        ],
        environment: environment,
        outputFilesDirectory: outputFilesDirectory
      ),
    ]
  }
}
