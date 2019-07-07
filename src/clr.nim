# clr: Get information about colors and convert them in the command line
#
# Copyright © 2018-2019 Hugo Locurcio and contributors
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

import cligen
import chroma
import colors
import re
import strformat
import strutils
import tables
import terminal

proc parseColor(color: string): chroma.Color =
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
      let colorHsl = ColorHSL(
        h: parseFloat(matches[0]),
        s: parseFloat(matches[1]),
        l: parseFloat(matches[2]),
      )

      return color(colorHsl)

    elif match(color, hsvRegex, matches):
      let colorHsv = ColorHSV(
        h: parseFloat(matches[0]),
        s: parseFloat(matches[1]),
        v: parseFloat(matches[2]),
      )

      return color(colorHsv)

  except:
    styledEcho(styleBright, fgRed, "Error: Could not parse color.")
    quit(1)

proc displayColor(color: chroma.Color) =
  ## Displays a color and some information in the terminal.

  # Create a color from the built-in colors module for the terminal
  let colorTerm = colors.rgb(
    int(color.r*255),
    int(color.g*255),
    int(color.b*255),
  )

  # Convert to HSL and HSV for displaying
  let colorHsl = hsl(color)
  let colorHsv = hsv(color)

  let colorStr = {
    "hex": toLowerAscii(toHtmlHex(color)),
    "rgb": toHtmlRgb(color),
    "hsl": &"hsl({int(colorHsl.h)}, {int(colorHsl.s)}%, {int(colorHsl.l)}%)",
    "hsv": &"hsv({int(colorHsv.h)}, {int(colorHsv.s)}%, {int(colorHsv.v)}%)",
  }

  # Display output

  echo("")

  for str in pairs(colorStr):
    let notation = toUpperAscii(str.val[0])
    styledEcho(styleBright, fgWhite, &"  {notation}   ", resetStyle, str.val[1])

  echo("")

  const squareSize = 4

  # Draw preview rectangles, surrounded by 1 row of margin
  for row in 0..squareSize:
    stdout.write(" ".repeat(3))

    if row != 0 and row != squareSize:
      setBackgroundColor(colorTerm)

    stdout.write(" ".repeat(int(float(squareSize)*1.9)))

    resetAttributes()
    stdout.write(" ".repeat(3))
    setBackgroundColor(bgWhite)
    stdout.write(" ".repeat(3))

    if row != 0 and row != squareSize:
      setBackgroundColor(colorTerm)

    stdout.write(" ".repeat(int(float(squareSize)*1.9)))

    setBackgroundColor(bgWhite)
    stdout.write(" ".repeat(3))
    resetAttributes()
    echo("")

  echo("")

proc main(
  invert: bool = false,
  lighten: float = 0.0,
  darken: float = 0.0,
  saturate: float = 0.0,
  desaturate: float = 0.0,
  spin: float = 0.0,
  color: seq[string]
) =
  ## Displays information about a color. The color can be modified
  ## before being displayed.
  ##
  ## The color must be written in one of the following formats:
  ##   - #RGB
  ##   - #RRGGBB
  ##   - rgb(R, G, B)
  ##   - hsl(H, S%, L%)
  ##   - hsv(H, S%, L%)
  ##   - HTML color names
  ##
  ## On shells such as Bash and zsh, you will have to write colors
  ## between quotes to avoid parse errors.
  if len(color) != 1:
    let word = if len(color) >= 3: "many" else: "few"
    styledEcho(styleBright, fgRed,
      &"""Error: Too {word} arguments specified ({len(color)} specified, 1 expected).
       Use --help to display a a list of commands."""
    )
    quit(1)

  var finalColor = parseColor(color[0]).lighten(lighten).darken(darken).saturate(saturate).desaturate(desaturate).spin(spin)

  if invert:
    finalColor = chroma.color(
      1.0 - finalColor.r,
      1.0 - finalColor.g,
      1.0 - finalColor.b
    )

  displayColor(finalColor)

# The COLORTERM environment variable must be set to "truecolor" or "24bit"
# for true color terminal output to work
enableTrueColors()

dispatch(main, help={
  "invert": "Invert the color",
  "lighten": "Lighten the color (0.0 = unchanged, 1.0 = white)",
  "darken": "Darken the color (0.0 = unchanged, 1.0 = black)",
  "saturate": "Saturate the color (0.0 = unchanged, 1.0 = double saturation)",
  "desaturate": "Desaturate the color (0.0 = unchanged, 1.0 = grayscale)",
  "spin": "Rotate the color's hue (0.0 = unchanged, 360.0 = full circle)",
})

# Always reset color codes when exiting
system.addQuitProc(resetAttributes)
