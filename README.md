# clr

**Get information about colors and convert them in the command line.**

## Use cases

- As HSL colors are easier to reason about by humans, you want to use an
  HSL color in software that only accepts RGB colors or hexadecimal
  color codes.
- You want to perform color manipulation to derive a color scheme from
  a base color.

## Installation

### Binary releases

Download a binary for your operating system on the
[Releases page](https://github.com/Calinou/clr/releases).
Make sure to place it in a location present in your `PATH` environment variable.

### Building from source

After installing [Nim](https://nim-lang.org/)
and [Nimble](https://github.com/nim-lang/nimble) (bundled with Nim),
enter the following command in a terminal:

```
nimble install clr
```

Using this installation method, clr will be immediately available in your `PATH`.

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
    - HTML color names

  <amount> must be a value between 0 and 1.
  The value will affect the color in an absolute manner.
```

### Colored output

For colors to look correct, you need to set the environment variable
`COLORTERM` to `truecolor`. You can make this permanent by adding the following
line to your shell startup file (such as `~/.bashrc` or `~/.zshrc`):

```bash
export COLORTERM="truecolor"
```

## License

Copyright © 2018 Hugo Locurcio and contributors

Unless otherwise specified, files in this repository are licensed under
the MIT license; see [LICENSE.md](LICENSE.md) for more information.
