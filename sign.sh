#!/bin/bash

for whl in wheelhouse/*.whl; do
    wheel sign "$whl"
done
