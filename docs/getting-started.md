## Download

Download pre-built binaries and the accompanying man page from the
[Release](https://github.com/aafulei/cpp-today/releases) page at GitHub.

Alternatively, you can build the program from source as shown in the next step.

## Build

Clone the [GitHub repository](https://github.com/aafulei/cpp-today). Then use
`make` to build the program:

```shell
make
```

## Run

If you downloaded the binary from the Release page, follow the instructions
there.

If you built the program yourself using `make`, you can run it with

```shell
make run
```

Alternatively, to run manually:

```shell
./bin/release/today
```

You should see the current date printed out in the `YY/MM/DD = Www` format, for
example

```
25/05/14 = Wed
```

## Install

To install the program, run

```shell
make install
```

The `man` page will be installed alongside the program. You might need `sudo`
privileges. Run `make help` for customization options. To install the
binary and the man page manually, copy them to their default destinations or to
directories of your choice:

| Source                | Default Destination          |
| --------------------- | ---------------------------- |
| `./bin/release/today` | `/usr/local/bin/`            |
| `./docs/man/today.1`  | `/usr/local/share/man/man3/` |

To uninstall the program and the man page, run

```shell
make uninstall
```

## Ask for Help

As is typical with command-line programs, run

```shell
today --help
```

for help. If the man page has been installed, you can run

```shell
man today
```

to view the manual page for more information.

---

*For source code and project files, please see the
[GitHub repository](https://github.com/aafulei/cpp-today).*

