#! /usr/bin/env bash

echo "Declare local repo checkout 'safe' for consumption..."
git config --global --add safe.directory /github/workspace

if [[ -n "$INPUT_PACKAGE_NAME" ]]; then
    PYPI_PACKAGE_NAME="${INPUT_PACKAGE_NAME}"
else
    echo "Cannot deduce package name: ${INPUT_PACKAGE_NAME}"
    exit 1
fi
export PYPI_PACKAGE_NAME="${PYPI_PACKAGE_NAME}"
echo "Package name: ${PYPI_PACKAGE_NAME}"

PACKAGE_VERSION=$(GITHUB_TOKEN=$INPUT_GITHUB_TOKEN pip-versions latest "${PYPI_PACKAGE_NAME}")

if [[ -n "$PACKAGE_VERSION" ]]; then
    OUTPUT_PACKAGE_VERSION="${PACKAGE_VERSION}"
    OUTPUT_PACKAGE_NAME_VERSION="${PYPI_PACKAGE_NAME}-${PACKAGE_VERSION}"
else
    echo "Cannot deduce package version: ${PACKAGE_VERSION}"
    exit 1
fi
echo "Package version: ${OUTPUT_PACKAGE_VERSION}"
echo "Package name-version: ${OUTPUT_PACKAGE_NAME_VERSION}"
