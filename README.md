# clr

**Get information about colors and convert them in the command line.**

## Use cases

- As HSL colors are easier to reason about by humans, you want to use an
  HSL color in software that only accepts RGB colors or hexadecimal
  color codes.
- You want to perform color manipulation to derive a color scheme from
  a base color.

## Installation

### Building from source

After installing [Nim](https://nim-lang.org/)
and [Nimble](https://github.com/nim-lang/nimble) (bundled with Nim),
enter the following commands in a terminal:

```
git clone https://github.com/Calinou/clr.git
cd clr
nimble install
```

## Usage

See the command-line help:

```
clr
Get information about colors and convert them in the command line.

Usage:
  clr info <color>
  clr invert <color>
  clr lighten <color> <amount>
  clr darken <color> <amount>
  clr saturate <color> <amount>
  clr desaturate <color> <amount>
  clr spin <color> <degrees>
  clr (-h | --help)
  clr (-V | --version)

Options:
  -h --help        Show this screen.
  -V --version     Show version.

Notes:
  <color> accepts the following color formats:
    - #RGB
    - #RRGGBB
    - rgb(R, G, B)
    - hsl(H, S%, L%)
    - hsv(H, S%, L%)

  <amount> must be a value between 0 and 1.
  The value will affect the color in an absolute manner.
```

## License

Copyright © 2018 Hugo Locurcio and contributors

Unless otherwise specified, files in this repository are licensed under
the MIT license; see [LICENSE.md](LICENSE.md) for more information.
