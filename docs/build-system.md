# Build System

This project features an all-in-one Make-based build system that enables users
to build, run, test, and install the program using `make`. To get started,
clone the [GitHub repository](https://github.com/aafulei/cpp-today), and run
`make` with the desired targets.

```shell
make             # Build release version
make debug       # Build debug version
make run         # Build and run release version
make run-debug   # Build and run debug version
make test        # Build and test release version
make test-debug  # Build and test debug version
make install     # Install program and man page
make uninstall   # Uninstall program and man page
make clean       # Remove build files
```

To list all targets and options, run

```shell
make help
```

which will show

```
Usage: make [CXX=c++] [CXX_STANDARD=c++23] [INST_DIR=/usr/local/bin]
            [MAN_DIR=/usr/local/share/man/man1] [ARGS] [target=all]

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
  man            - Build man page
  dist           - Build program and man page
  install        - Install program and man page
  uninstall      - Uninstall program and man page
  clean          - Remove release and debug build files
  clean-release  - Remove release build files
  clean-debug    - Remove debug build files
  show           - Show operating system and compiler info
  show-os        - Show operating system info
  show-compiler  - Show compiler info
  show-version   - Show version number
  help           - Show this help message and exit

Variables:
  CXX            - C++ compiler (default: c++).
  CXX_STANDARD   - C++ standard (default: c++23).
  INST_DIR       - Install dir for program (default: /usr/local/bin)
  MAN_DIR        - Install dir for man page (default: /usr/local/share/man/man1)
  ARGS           - Command-line arguments to forward to program

Examples:
  make                          # Build release version
  make all                      # Build release version
  make release                  # Build release version
  make debug                    # Build debug version
  make run-debug                # Build and run debug version
  make test-debug               # Build and test debug version
  make dist                     # Build program and man page
  make CXX=g++                  # Build with g++ compiler
  make CXX_STANDARD=c++20       # Build with C++20 standard
  make INST_DIR=/opt install    # Install to /opt
  make INST_DIR=/opt uninstall  # Uninstall from /opt
  make MAN_DIR=/opt install     # Install, saving man page to /opt
  make MAN_DIR=/opt uninstall   # Uninstall, removing man page from /opt
  make ARGS=--help run-debug    # Run debug-version program with --help
```

---

*For source code and project files, please see the
[GitHub repository](https://github.com/aafulei/cpp-today).*
