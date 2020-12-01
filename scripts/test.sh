#!/usr/bin/bash

runReport() {
    if [ -f "lcov.info" ] && ! [ "$TRAVIS" ]; then
        genhtml lcov.info -o coverage --no-function-coverage -s -p `pwd`
        open coverage/index.html
    fi
}