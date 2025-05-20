# CppToday

[![Check](https://github.com/aafulei/cpp-today/actions/workflows/check.yml/badge.svg)](https://github.com/aafulei/cpp-today/actions/workflows/check.yml)
[![Build](https://github.com/aafulei/cpp-today/actions/workflows/build.yml/badge.svg)](https://github.com/aafulei/cpp-today/actions/workflows/build.yml)
[![Test](https://github.com/aafulei/cpp-today/actions/workflows/test.yml/badge.svg)](https://github.com/aafulei/cpp-today/actions/workflows/test.yml)

![](./docs/img/logo.svg)

*A minimal but complete Make-based C++23 project template.*

This project packages a simple C++23 command-line program, including essential
tools and workflows for building, testing, and maintaining the code. The
program prints the current date in the `YY/MM/DD = Www` format (e.g., `25/05/14
= Wed`).

Project website:
[**aafulei.github.io/cpp-today**](https://aafulei.github.io/cpp-today).

## Features

- Minimal, complete C++23 project template
- Simple and reliable Make-based build system
- Test scripts for manual and automated testing
- Code formatting support with Clang Format
- Editor tooling support via Clangd
- Built-in CI/CD workflows using GitHub Actions
- Project documentation website generated with MkDocs

## Supported Platforms

- macOS
- Linux

## Getting Started

### Download

Download pre-built binaries from the
[Release](https://github.com/aafulei/cpp-today/releases)
page (or build from source as shown below).

### Build

Clone the [GitHub repository](https://github.com/aafulei/cpp-today). Use `make`
to build the program:

```shell
make
```

### Run

- If you downloaded the binary from the
[Release](https://github.com/aafulei/cpp-today/releases)
page, follow the instructions there.

- If you built it yourself using `make`, run the executable located at:

```shell
./bin/release/today
```

Alternatively, you can build and run the program in one step:

```shell
make run
```

### Result

You should see the current date printed out in the `YY/MM/DD = Www` format, e.g.

```
25/05/14 = Wed
```

## Build System

This project features a simple and reliable Make-based build system that allows
you to use `make` to build, run, and test the program.

```shell
make             # Build release version
make debug       # Build debug version
make run         # Build and run release version
make run-debug   # Build and run debug version
make test        # Build and test release version
make test-debug  # Build and test debug version
make clean       # Remove build files
```

To list all targets and options, run `make help`.

## Project Structure

- [`.github/workflows/`](./.github/workflows/) – GitHub Actions workflows
- [`docs/`](./docs/) – documentation files for MkDocs and Doxygen
- [`src/`](./src/) – source code
- [`tests/`](./tests/) – test scripts
- [`.clang-format`](./.clang-format) – Clang Format configuration
- [`.gitignore`](./.gitignore) – Git ignore patterns
- [`Doxyfile`](./Doxyfile) – Doxygen configuration file
- [`DoxygenLayout.xml`](./DoxygenLayout.xml) – Doxygen website layout
- [`LICENSE`](./LICENSE) – software license
- [`Makefile`](./Makefile) – Make build script
- [`README.md`](./README.md) – repository documentation (this file)
- [`compile_flags.txt`](./compile_flags.txt) – Clangd compile options
- [`mkdocs.yml`](./mkdocs.yml) – MkDocs project website configuration

## Author

Aaron Fu Lei

## License

MIT

## Version

0.2.0

## Changelog

For detailed version updates, please see the [CHANGELOG](./CHANGELOG.md).
