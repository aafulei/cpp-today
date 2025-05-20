# Changelog

## [0.3.0](https://github.com/aafulei/cpp-today/releases/tag/v0.3.0) - 2025-05-20

**Managing a single source of truth between program and man page.**

### Added

- Source code:
    - `VERSION` macro
    - `--help` and `--version` options
- Build system:
    - `make man`
    - `make dist`
    - `make install/uninstall` with man page
    - `make show-version`
    - `make run` with `ARGS` for command-line arguments
    - Banners to show information about current stages
- Project website:
    - User Guide section
    - Technical Details section
        - Single Source of Truth subsection
        - Makefile in Detail subsection
        - Ready for Deployment subsection
    - Enable features for code copy, footer, navigation
    - Enable extensions for code highlight
- Manual page:
    - Man page with conversion from `help2man`
- Assets:
    - Mermaid diagrams for project website and code reference
    - Screenshots of man page and help info
- Project information:
    - `Changelog.md`:
        - Version 0.3.0
    - `VERSION` as the definitive source for software version

### Changed

- Build system:
    - Do not use `BINSTAMP`; just use order-only prerequisite on `BIN_DIR`

## [0.2.0](https://github.com/aafulei/cpp-today/releases/tag/v0.2.0) - 2025-05-20

**Integrated with Doxygen for source code documentation.**

### Added

- Source code:
    - Doxygen-style comments
- Testing:
    - `test.sh`
- Build system:
    - Full support of `release` and `debug` branches
    - `make test`
    - `make install/uninstall`
    - `make show-os`
    - `make show-compiler`
- Automation:
    - GitHub Actions:
        - `build.yml` for automatic building workflow on latest macOS and Ubuntu
        - `test.yml` for automatic testing workflow on latest macOS and Ubuntu
        - `check.yml` for automatic code format check workflow on latest macOS
- Project website:
    - MkDocs with the Material theme:
        - Getting Start section
        - Testing section
        - Build System section
- Code reference:
    - Doxygen:
        - `Doxyfile` for docs generation
        - `DoxygenLayout.xml` for website layout
- Assets:
    - `.svg` images for CppToday logo and icon
    - `.css` files to customize website appearance
- Project information:
    - `LICENSE` for software license (MIT)
    - `.gitignore`
        - Ignore `site/` and `venv/`
        - Ignore doxygen, original, backup files
    - `CHANGELOG.md` for Changelog:
        - Version 0.2.0
        - Version 0.1.0

## [0.1.0](https://github.com/aafulei/cpp-today/releases/tag/v0.1.0) - 2025-05-13

**Initial release of the `today` program.**

### Added

- Source code:
    - `today.cpp` - Initial release of the `today` program
- Build system:
    - `Makefile` - Simple Make-based build system
- Code formatting configuration:
    - `.clang-format` for Clang Format
- Editor tooling support:
    - `compile_flags.txt` for `clangd`
- Project information:
    - `.gitignore` for patterns to ignore by Git
