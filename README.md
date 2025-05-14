# Today

A simple C++23 program that prints the current date in the `YY/MM/DD = Www`
format.

*This repository serves as a minimal but complete C++ project template.*

## Features

- Minimal, complete C++ project template
- Simple and reliable `make` build system
- Test scripts for manual and automated testing
- Code formatting support with `clang-format`
- Editor tooling support via `clangd`

## Supported Platforms

- macOS
- Linux

## Getting Started

Download pre-built binaries from the
[Release](https://github.com/aafulei/cpp-today/releases)
page, or build from source:

```shell
make
```

Then, run the program:

```shell
./bin/release/today
```

Alternatively, you can build and run in one step:

```shell
make run
```

You should see the current date printed out in the `YY/MM/DD = Www` format, e.g.

```
25/05/12 = Mon
```

## Build

Use `make` to build the program:

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

| File                                       | Description                          |
| ------------------------------------------ | ------------------------------------ |
| [`src/today.cpp`](./src/today.cpp)         | C++ source code                      |
| [`tests/test.sh`](./tests/test.sh)         | Test script                          |
| [`.clang-format`](./.clang-format)         | Formatting config for `clang-format` |
| [`.gitignore`](./.gitignore)               | Patterns to ignore for `git`         |
| [`LICENSE`](./LICENSE)                     | Software license                     |
| [`Makefile`](./Makefile)                   | Build script for `make`              |
| [`README.md`](./README.md)                 | This file                            |
| [`compile_flags.txt`](./compile_flags.txt) | Compile options for `clangd`         |

## Author

Aaron Fu Lei

## License

MIT

## Version

0.1.0
