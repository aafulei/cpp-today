# Getting Started

## Download

Download pre-built binaries from the
[Release](https://github.com/aafulei/cpp-today/releases)
page (or build from source as shown below).

## Build

Clone the [GitHub repository](https://github.com/aafulei/cpp-today). Use `make`
to build the program:

```shell
make
```

## Run

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

## Result

You should see the current date printed out in the `YY/MM/DD = Www` format, e.g.

```
25/05/14 = Wed
```

## Install

Install the program with

```shell
make install
```

You might need `sudo`. Default install path is `/usr/local/bin`. See `make help`
for customization. To uninstall the program, run `make uninstall`.

---

*For more details, see the
[GitHub repository](https://github.com/aafulei/cpp-today).*
