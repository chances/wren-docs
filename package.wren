import "wren-package" for WrenPackage, Dependency

class Package is WrenPackage {
  construct new() {}
  name { "docs" }
  dependencies {
    return [
      Dependency.new("wren-args", "master", "https://github.com/nanaian/wren-args.git"),
      Dependency.new("wren-assert", "v1.1.2", "https://github.com/RobLoach/wren-assert.git"),
      Dependency.new("wren-colors", "master", "https://github.com/gsmaverick/wren-colors.git"),
      Dependency.new("wren-path", "v1.0.0", "https://github.com/RobLoach/wren-path.git")
    ]
  }
}

Package.new().default()
