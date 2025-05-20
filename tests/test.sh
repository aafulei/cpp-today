#!/usr/bin/env bash

if [ -z "$1" ]; then
    echo "Usage: $0 <executable>"
    exit 2
fi

exec_path=$1
expected=$(date "+%y/%m/%d = %a")

if [ ! -x "$exec_path" ]; then
    echo "Executable not found or not executable: $exec_path"
    exit 3
fi

actual=$($exec_path)

if [[ "$actual" == "$expected" ]]; then
    echo "Test passed: $actual"
    exit 0
else
    echo "Test failed!"
    echo "Expected: $expected"
    echo "Actual  : $actual"
    exit 1
fi
