# Makefile in Detail

This note explains two key techniques used in the
[`Makefile`](https://github.com/aafulei/cpp-today/blob/main/Makefile) for this
project:

- Order-only prerequisites
- Dependency (`.d`) files

## Order-Only Prerequisites

The syntax of a typical `make` rule is:

```makefile
target: normal-prerequisites | order-only-prerequisites
    recipe
```

An *order-only prerequisite* is a prerequisite that comes after normal
prerequisites, separated by a vertical bar (`|`). Like normal prerequisites,
order-only prerequisites must be built before the main target. However, unlike
normal prerequisites, changes in the timestamps of order-only prerequisites
do *not* trigger rebuilds.

In this
[`Makefile`](https://github.com/aafulei/cpp-today/blob/main/Makefile),
the binary directory `$(BIN_DIR)` is an order-only prerequisite:

```makefile
$(BIN): $(OBJ) | $(BIN_DIR)
```

This rule ensures that the output directory `BIN_DIR` (`./bin/release` or
`./bin/debug`) exists before building the binary `BIN`, but any timestamp
changes in that directory won't cause the binary to be rebuilt.

## Dependency (`.d`) files

`.d` files record header dependencies for each source file, enabling automatic
recompilation when headers change. They serve as an automatic replacement for
explicitly listing headers like:

```makefile
foo.o: foo.cpp foo.hpp
```

With `.d` files, you only need to write:

```makefile
foo.o: foo.cpp
```

and auto-generated `.d` files will handle tracking header dependencies for you.

The [`Makefile`](https://github.com/aafulei/cpp-today/blob/main/Makefile)
for this project generates `.d` files during compilation with:

```makefile
$(BIN_DIR)/%.o: $(SRC_DIR)/%.cpp $(VER_FILE) | $(BIN_DIR)
    $(CXX) $(CXXFLAGS) -MMD -MP -c $< -o $@
```

where

- `-MMD` creates `.d` files excluding system headers.
- `-MP` adds phony targets to prevent errors if headers are deleted.

These `.d` files are included via:

```makefile
-include $(DEP)
```

where `$(DEP)` stand for all the dependency files corresponding to source `.cpp`
files (e.g. `today.d` for `today.cpp`). This ensures that changes in header
files trigger necessary recompilation automatically.

*Note that, as a sample project, this project does not necessitate `.d` files
 for its own sake; however, we include this technique here since it represents
 an industry best practice.*

#### Why the `-MP` Option?

The `-MP` option causes the compiler to generate phony targets for all relevant
header files in the `.d` files. This prevents `make` from failing if some
headers are deleted later, since the phony targets act as placeholders for the
missing files, allowing the build to proceed without errors.

#### Role of `-include $(DEP)`

The `-include` directive includes `.d` dependency files *if they exist*, but
suppresses errors if they don't. The leading `-` tells `make` to ignore missing
files instead of failing, which is important the first time the project is
built before any `.d` files are generated.

---

*For source code and project files, please see the
[GitHub repository](https://github.com/aafulei/cpp-today).*
