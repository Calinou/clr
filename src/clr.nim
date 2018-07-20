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
import chroma
import re
import strutils
import terminal

proc parseColor(color: string): Color =
  ## Parses a string such as `#FF0000` or `hsl(0, 100%, 50%)` to a color object.
  try:
    # Parse using chroma first
    return parseHtmlColor(color)

  except InvalidColor:
    # chroma doesn't parse HTML HSL/HSV color notations,
    # so we have to do it ourselves
    let hslRegex = re"hsl\((\d+),\s?(\d+)%?,\s?(\d+)%?\)"
    let hsvRegex = re"hsv\((\d+),\s?(\d+)%?,\s?(\d+)%?\)"
    # There are always 3 values to capture in each regular expression
    var matches: array[3, string]

    if match(color, hslRegex, matches):
      let colorHSL = ColorHSL(
        h: parseFloat(matches[0]),
        s: parseFloat(matches[1]),
        l: parseFloat(matches[2]),
      )

      return color(colorHSL)

    elif match(color, hsvRegex, matches):
      let colorHSV = ColorHSV(
        h: parseFloat(matches[0]),
        s: parseFloat(matches[1]),
        v: parseFloat(matches[2]),
      )

      return color(colorHSV)

  except:
    echo "Could not parse color."

let args = docopt(doc, version = "0.1.0")

if args["info"]:
  setForegroundColor(fgRed, false)
  echo parseColor($args["<color>"])

# Always reset color codes when exiting
system.addQuitProc(resetAttributes)
