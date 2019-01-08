# Package

version       = "0.1.3"
author        = "Hugo Locurcio"
description   = "Get information about colors and convert them in the command line"
license       = "MIT"
srcDir        = "src"
bin           = @["clr"]

# Dependencies

requires "nim >= 0.18.0"
requires "chroma#1bbe72ead9fe8270a8d038eb92bd4f83b3f0fc87"
requires "docopt#0abba63023a2e246f242e5aefa5d2000b327e11b"
