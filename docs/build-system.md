# Build System

This project features a simple and reliable Make-based build system.

To use it, clone the [GitHub repository](https://github.com/aafulei/cpp-today),
and use `make` to build, run, test and install the program.

```shell
make             # Build release version
make debug       # Build debug version
make run         # Build and run release version
make run-debug   # Build and run debug version
make test        # Build and test release version
make test-debug  # Build and test debug version
make install     # Build and install release version
make uninstall   # Remove installed program
make clean       # Remove build files
```

To list all targets and options, run

```shell
make help
```

which will show

```
Usage: make [CXX=c++] [CXX_STANDARD=c++23] [target]

Targets:
  all            - Build release version (default)
  release        - Build release version
  debug          - Build debug version
  run            - Build and run release version
  run-release    - Build and run release version
  run-debug      - Build and run debug version
  test           - Build and test release version
  test-release   - Build and test release version
  test-debug     - Build and test debug version
  install        - Build and install release version
  uninstall      - Remove installed program
  clean          - Remove release and debug build files
  clean-release  - Remove release build files
  clean-debug    - Remove debug build files
  show           - Show operating system and compiler info
  show-os        - Show operating system info
  show-compiler  - Show compiler info
  help           - Show this help message and exit

Variables:
  CXX            - C++ compiler (default: c++).
  CXX_STANDARD   - C++ standard (default: c++23).
  PREFIX         - Installation prefix (default: /usr/local)
  INSTALL_DIR    - Installation directory (default: $PREFIX/bin)

Examples:
  make                              # Build release version
  make all                          # Build release version
  make release                      # Build release version
  make debug                        # Build debug version
  make run-debug                    # Build and run debug version
  make test-debug                   # Build and test debug version
  make CXX=g++                      # Build with g++ compiler
  make CXX_STANDARD=c++20           # Build with C++20 standard
  make PREFIX=/opt/local install    # Install to /opt/local/bin
  make PREFIX=/opt/local uninstall  # Remove program from /opt/local/bin
```

---

*For more details, see the
[GitHub repository](https://github.com/aafulei/cpp-today).*
