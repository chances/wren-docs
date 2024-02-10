/// Documentation generator for Wren modules.
///
/// This tool parses Wren files, looking for doc-comments comments:
/// - `///`, and
/// - `/** */`
///
/// Generated documenation is saved to `./docs`.
///
/// ## GitHub Flavored Markdown
///
/// ## Prior Art
///
/// - The D programming language's [documentation generator](https://dlang.org/spec/ddoc.html) (AKA DDoc).
/// - The Domepunk [documentation generator](https://github.com/NinjasCL/domepunk/blob/main/tools/docs/__main__.py).
///
/// Authors: Chance Snow <git@chancesnow.me>
/// Copyright: Copyright © 2024 Chance Snow
/// License: MIT License
import "io" for File, Directory, Stdin, Stderr
import "os" for Process

import "./analyzer" for Analyzer
import "./ensure" for Ensure
import "./wren_modules/wren-path/Path" for Path
import "./wren_modules/wren-args/args" for Args

var cwd = Process.cwd
var args = Args.parse(Process.arguments)
var flags = args[0]
var params = args[1]
if (flags["version"]) System.print("v0.1.0")
if (flags["verbose"] || flags["v"] || flags["help"] || flags["h"]) {
  System.print("Wren Documentation Generator (Wren v%(Process.version))")
}
if (flags["help"] || flags["h"]) {
  System.print("\nUsage: wren-docs [flags]")
  System.print("\nFlags:")
  System.print("\t--version\tPrint this module's version")
  System.print("\t-v, --verbose\tPrint verbose diagnostic output")
  System.print("\t-h, --help\tPrint this help message")
  // TODO: System.print("\t-o, --output\tSets the output directory, defaults to `docs`")
  Process.exit()
}
// Bail if the user only wanted the version
if (flags["version"]) Process.exit()

Ensure.exec("mkdir", ["-p", "docs"])
// Create index of generated documentation
Ensure.exec("touch", [Path.join([cwd, "docs", "index.json"])])

// Find Wren sources
// TODO: Recursivly search for sources, ignoring "wren_modules" directories
var sources = {}
Directory.list(cwd).where {|entry|
  return entry.endsWith(".wren") && File.exists(entry)
}.each {|entry|
  var path = Path.join([cwd, entry])
  sources[path] = Analyzer.parse(path, File.read(path))
}
System.print("Parsed %(sources.keys.count) modules")
// TODO: Read all *.wren files, parse symbols and neighboring comments, emit docs
// NOTE: "There is a convention that methods ending in "_" are private." See https://github.com/wren-lang/wren/issues/117 and https://github.com/wren-lang/wren/issues/498#issuecomment-376209364
