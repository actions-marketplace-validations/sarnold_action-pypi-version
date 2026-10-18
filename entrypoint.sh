#! /usr/bin/env bash

if [[ "${CI}" = "true" ]]; then
    echo "Declare local repo checkout 'safe' for consumption..."
    git config --global --add safe.directory /github/workspace
else
    echo "CI is NOT true, leave git config alone..."
    export GITHUB_OUTPUT=""
fi

if [[ -n "$INPUT_PACKAGE_NAME" ]]; then
    PYPI_PACKAGE_NAME="${INPUT_PACKAGE_NAME}"
else
    echo "Cannot deduce package name: ${INPUT_PACKAGE_NAME}"
    exit 1
fi
export PYPI_PACKAGE_NAME="${PYPI_PACKAGE_NAME}"
echo "Package name: ${PYPI_PACKAGE_NAME}"

PACKAGE_VERSION=$(GITHUB_TOKEN=$INPUT_GITHUB_TOKEN pip-versions latest "${PYPI_PACKAGE_NAME}")
PACKAGE_NAME_VERSION="${PYPI_PACKAGE_NAME}-${PACKAGE_VERSION}"

if [[ -n "$PACKAGE_VERSION" ]]; then
    if [[ "${CI}" = "true" ]]; then
        echo PACKAGE_VERSION="${PACKAGE_VERSION}" >> "${GITHUB_OUTPUT}"
        echo PACKAGE_NAME_VERSION="${PACKAGE_NAME_VERSION}" >> "${GITHUB_OUTPUT}"
    fi
else
    echo "Cannot deduce package version: ${PACKAGE_VERSION}"
    exit 1
fi
echo "Package version: ${PACKAGE_VERSION}"
echo "Package name-version: ${PACKAGE_NAME_VERSION}"
