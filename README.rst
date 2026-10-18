(Github) action-pypi-version
============================

|CI| |pre|

|tag| |license|

What is pip-versions?
---------------------

The pip-versions_ tool retrieves version information about a package from
both pypi_ and private repos.

What you can do with action-pypi-version:

* provide a (Python) package name and get back the latest version (from Pypi only)

By default this action will retrieve the latest version and output both the
<version> string and the full <name-version> string.

.. _pypi: https://pypi.org/
.. _pip-versions: https://github.com/willemt/pip-versions/

Usage
-----

To get the latest version of a package from pypi, the default configuration
is dead-simple: simply provide a package name hosed on Pypi.  Note this is
primarily intended to be a single step in an existing workflow, as shown in
the example below.

.. note:: Be sure to use the latest tag for this action if you're not
          tracking 'v1' or the ``main`` branch.

Default configuration
~~~~~~~~~~~~~~~~~~~~~

::

  jobs:
    mirror:
      name: main
      runs-on: ubuntu-24.04
      steps:
      - uses: actions/checkout@v6
      - uses: actions/setup-python@v6
        with:
          python-version: '3.10'

      - name: Get latest version
        id: get_version
        uses: sarnold/action-pypi-version@v1
        with:
          package_name: asterisklint
  ...

Somewhere else in the same job::

      - name: Display version
        run: |
          echo "pkg version:" ${{ steps.get_version.outputs.package_name_version }}


Input Options
-------------

:package_name: package name to use in version query
:github_token: GITHUB_TOKEN secret (automatically provided by Github)


Output Variables
----------------

:package_version: Only the package version string
:package_name_version: The full package "name-version" string


Operating System Support
------------------------

This action runs in a Docker container and requires the Ubuntu_ CI runner.
In your workflow job configuration, you should set the ``runs-on``
property to ``ubuntu-latest``::

    jobs:
      release:
        runs-on: ubuntu-latest


.. _Ubuntu: https://ubuntu.com/


.. |CI| image:: https://github.com/sarnold/action-pypi-version/actions/workflows/test.yml/badge.svg
    :target: https://github.com/sarnold/action-pypi-version/actions/workflows/test.yml
    :alt: GitHub CI test status

.. |pre| image:: https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&amp;logoColor=white
   :target: https://github.com/pre-commit/pre-commit
   :alt: pre-commit

.. |tag| image:: https://img.shields.io/github/v/tag/sarnold/action-pypi-version?color=green&include_prereleases&label=latest%20release
    :target: https://github.com/sarnold/action-pypi-version/releases
    :alt: GitHub tag

.. |license| image:: https://img.shields.io/github/license/sarnold/action-pypi-version?cacheSeconds=360
    :target: https://github.com/sarnold/action-pypi-version/blob/main/LICENSE
    :alt: GitHub License
