# Package

version       = "0.1.0"
author        = "Hugo Locurcio"
description   = "Get information about colors and convert them in the command line"
license       = "MIT"
srcDir        = "src"
bin           = @["clr"]

# Dependencies

requires "nim >= 0.18.1"
requires "colorsys >= 0.2.0"
requires "docopt >= 0.6.5"
