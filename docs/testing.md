# Testing

This project includes test scripts for manual and automated testing.

To test the program, clone the
[GitHub repository](https://github.com/aafulei/cpp-today), and use `make` to run
the tests.

```shell
make test           # Build and test release version
make test-debug     # Build and test debug version
```

These commands run `tests/test.sh` on the respective builds.

On success, you should see output like

```
Test passed: 25/05/14 = Wed
```

Otherwise, you will see

```
Test failed!
```

---

*For more details, see the
[GitHub repository](https://github.com/aafulei/cpp-today).*
