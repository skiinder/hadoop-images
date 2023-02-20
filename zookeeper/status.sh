#!/bin/bash
test "$(echo ruok | nc localhost 2181)" = "imok" && exit 0 || exit 1
