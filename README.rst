======
Readme
======

These scripts allow one to create wheels for Zope / Zope Toolkit
projects in bulk.

Start a docker container via::

    ./start.st

Inside the container do::

    cd /io
    ./get.sh
    ./build.sh

Stop the container::

    exit

Outside the container::

    ./sign.sh

Remove projects with missing permissions::

    rm -f wheelhouse/zope.processlifetime*
    
Upload to PyPi::

    ls wheelhouse/*.whl
    twine upload --sign --skip-existing wheelhouse/*.whl
