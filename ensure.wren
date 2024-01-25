import "ensure" for Ensure as Base
import "os" for Process

class Ensure is Base {
  /// Params:
  ///   program: String
  static exec(program) {
    var result = Process.exec(program)
    Base.int(result, "result")
    if (result != 0) Fiber.abort("ArgumentError: Process returned non-zero status.")
  }

  /// Params:
  ///   program: String
  ///   arguments: [String]
  static exec(program, arguments) {
    var result = Process.exec(program, arguments)
    Base.int(result, "result")
    if (result != 0) Fiber.abort("ArgumentError: Process returned non-zero status.")
  }
}
