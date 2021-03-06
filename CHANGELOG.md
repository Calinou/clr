# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.0] - 2019-07-08

### Changed

- Reimplemented command-line argument parsing using
  [cligen](https://github.com/c-blake/cligen).
  - Command syntax is now `clr <color>` with optional parameters (see `clr --help`).
  - Multiple options can now be chained, e.g.
    `clr blue --lighten 0.2 --desaturate 0.4`.
- Nim 0.19.2 or later is now required to build `clr` from source.

## [0.1.3] - 2019-01-08

### Fixed

- Compiling from source now works with Nim 0.19.0 or later.

## [0.1.2] - 2018-07-26

### Added

- macOS binaries are now available.

## [0.1.1] - 2018-07-24

### Added

- 32-bit Windows binaries are now available.

### Changed

- Improved packaging of releases.

## 0.1.0 - 2018-07-22

- Initial versioned release.

[Unreleased]: https://github.com/Calinou/clr/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/Calinou/clr/compare/v0.1.3...v1.0.0
[0.1.3]: https://github.com/Calinou/clr/compare/v0.1.2...v0.1.3
[0.1.2]: https://github.com/Calinou/clr/compare/v0.1.1...v0.1.2
[0.1.1]: https://github.com/Calinou/clr/compare/v0.1.0...v0.1.1
