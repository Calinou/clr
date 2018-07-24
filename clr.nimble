# Package

version       = "0.1.1"
author        = "Hugo Locurcio"
description   = "Get information about colors and convert them in the command line"
license       = "MIT"
srcDir        = "src"
bin           = @["clr"]

# Dependencies

requires "nim >= 0.18.0"
requires "chroma >= 0.0.1"
requires "docopt >= 0.6.5"
