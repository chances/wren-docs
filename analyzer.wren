/// Authors: Chance Snow <git@chancesnow.me>
/// Copyright: Copyright © 2024 Chance Snow
/// License: MIT License
import "./wren_modules/wrenalyzer/lexer" for Lexer
import "./wren_modules/wrenalyzer/parser" for Parser
import "./wren_modules/wrenalyzer/reporter" for PrettyReporter
import "./wren_modules/wrenalyzer/source_file" for SourceFile

class Analyzer {
  /// Params:
  ///   path: String
  ///   code: String
  static parse(path, code) {
    __reporter = __reporter == null ? PrettyReporter.new() : __reporter

    var source = SourceFile.new(path, code)
    var lexer = Lexer.new(source)
    var parser = Parser.new(lexer, __reporter)
    return parser.parseModule()
  }
}
