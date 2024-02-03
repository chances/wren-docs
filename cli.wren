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

import "./ensure" for Ensure
import "./wren_modules/wren-path/Path" for Path
import "./wren_modules/wren-args/args" for Args

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

// Create and switch to the docs directory
Ensure.exec("mkdir", ["-p", "docs"])
var cwd = Process.cwd
Process.chdir(Path.join([cwd, "docs"]))

// Create 
Ensure.exec("touch", ["index.json"])
// TODO: Read all *.wren files, parse symbols and neighboring comments, emit docs

