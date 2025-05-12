# Today

A simple C++ program that prints the current date in the `YY/MM/DD = Www`
format.

*This repository serves as a minimal but complete C++ project template.*

## Features

- Minimal and complete C++23 project template
- Simple and reliable build system with dependency tracking
- Integrated code formatting and editor tooling support

## Supported Platforms

- macOS
- Linux

## Getting Started

Download pre-built binaries from the
[Release](https://github.com/aafulei/cpp-today/releases)
page, or build it from source and run the program:

```shell
make && ./bin/today
```

Equivalently, run in one step with

```shell
make run
```

You will see the current date in the `YY/MM/DD = Www` format, e.g.

```
25/05/12 = Mon
```

## Build

Use `make` to build the program:

```shell
make        # build release version
make run    # build and run release version
make debug  # build debug version
make clean  # clean build files
```

To list all targets and options, run `make help`.

## Project Structure

| File                                       | Description                          |
| ------------------------------------------ | ------------------------------------ |
| [`src/today.cpp`](./src/today.cpp)         | C++ source code                      |
| [`.clang-format`](./.clang-format)         | formatting config for `clang-format` |
| [`.gitignore`](./.gitignore)               | patterns to ignore for `git`         |
| [`compile_flags.txt`](./compile_flags.txt) | compile options for `clangd`         |
| [`Makefile`](./Makefile)                   | build script for `make`              |
| [`README.md`](./README.md)                 | this file                            |

## Author

Aaron FU Lei

## License

MIT
