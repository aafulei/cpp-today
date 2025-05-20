# Testing

This project includes test scripts for both manual and automated testing.

To test the program, clone the
[GitHub repository](https://github.com/aafulei/cpp-today), then use `make` to
to run the tests.

```shell
make test           # Build and test release version
make test-debug     # Build and test debug version
```

These commands will run `tests/test.sh` against the corresponding build.

On success, you should see output similar to

```
Test passed: 25/05/14 = Wed
```

Otherwise, you will see

```
Test failed!
```

---

*For source code and project files, please see the
[GitHub repository](https://github.com/aafulei/cpp-today).*
