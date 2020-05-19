#!/bin/sh
set -eux
mkdir -p results
/usr/bin/python test.py > results/macos10.15.4.system.python2.7.16
/Library/Frameworks/Python.framework/Versions/3.8/bin/python3 test.py > results/macos10.15.4.system.python3.8.2
docker run -v $PWD:/testpy:rw -u root -it --rm quay.io/python-devs/ci-image sh -c 'python3.9 /testpy/test.py > /testpy/results/ci-image.python3.9'
docker run -v $PWD:/testpy:rw -u root -it --rm quay.io/python-devs/ci-image sh -c 'python3.8 /testpy/test.py > /testpy/results/ci-image.python3.8'
docker run -v $PWD:/testpy:rw -u root -it --rm quay.io/python-devs/ci-image sh -c 'python3.7 /testpy/test.py > /testpy/results/ci-image.python3.7'
docker run -v $PWD:/testpy:rw -u root -it --rm quay.io/python-devs/ci-image sh -c 'python3.6 /testpy/test.py > /testpy/results/ci-image.python3.6'
docker run -v $PWD:/testpy:rw -u root -it --rm quay.io/python-devs/ci-image sh -c 'python3.5 /testpy/test.py > /testpy/results/ci-image.python3.5'
docker run -v $PWD:/testpy:rw -u root -it --rm quay.io/python-devs/ci-image sh -c 'python2.7 /testpy/test.py > /testpy/results/ci-image.python2.7'
