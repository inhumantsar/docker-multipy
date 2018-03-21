# docker-multipy

* Uses `pyenv` to supply multiple Python versions to `tox`.
* `inhumantsar/multipy` is an ONBUILD image designed to help with automated testing.
* `inhumantsar/multipy:shell` launches into `bash`
* Alpine-based images

## Quick Start

**NOTE**: Everything here assumes you already have a Python project.

1. Create a Dockerfile which inherits multipy.


    FROM inhumantsar/multipy
    # seriously, this is the whole file.

2. Add a pythons.txt file with a list of *exact* versions.


    2.7.14
    3.6.4
    ...

3. Add a tox.ini file.


    [tox]
    envlist = py27, py36, ...
    ...

4. Build your image.


    docker build -t mytoximage .

5. Run the image.


    docker run --rm mytoximage
