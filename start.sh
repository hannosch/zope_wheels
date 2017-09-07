#!/bin/bash
set -e -x

docker run --rm -it -v `pwd`:/io quay.io/pypa/manylinux1_x86_64 bash
