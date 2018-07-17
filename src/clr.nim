# clr: Get information about colors and convert them in the command line
#
# Copyright © 2018 Hugo Locurcio and contributors
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

let doc = """
clr
Get information about colors and convert them in the command line.

Usage:
  clr info <color>
  clr invert <color>
  clr light <color> <lightness>
  clr saturate <color> <saturation>
  clr rotate <color> <degrees>
  clr (-h | --help)
  clr (-V | --version)

Options:
  -h --help        Show this screen.
  -V --version     Show version.
"""

import docopt
import colorsys
import re
import strutils
import terminal

type Color = tuple
  red: float
  green: float
  blue: float
  hue: float
  saturation: float
  lightness: float
  value: float

proc parseColor(color: string): seq[float] =
  ## Parses a string such as `rgb(255, 0, 0)` or `#ff0000` to a Color struct.
  let hexShortRegex = re"#([0-9A-f])([0-9A-f])([0-9A-f])"
  let hexLongRegex = re"#([0-9A-f]{2})([0-9A-f]{2})([0-9A-f]{2})"
  let rgbRegex = re"rgb\((\d+),\s?(\d+),\s?(\d+)\)"
  let hslRegex = re"hsl\((\d+),\s?(\d+)%?,\s?(\d+)%?\)"
  let hsvRegex = re"hsv\((\d+),\s?(\d+)%?,\s?(\d+)%?\)"

  var hexShortMatches: seq[string] = @[]

  if match(color, hexShortRegex, hexShortMatches):
    for index, match in hexShortMatches.pairs:

  else:
    echo "Could not parse color."

  return colors

let args = docopt(doc, version = "0.1.0")

if args["info"]:
  setForegroundColor(fgRed, false)
  parseColor($args["<color>"])

system.addQuitProc(resetAttributes)
