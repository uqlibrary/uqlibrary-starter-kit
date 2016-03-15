#!/bin/bash

echo "Testing branch: ${CI_BRANCH}"

# Only run if not GH-PAGES
if [ ${CI_BRANCH} != "gh-pages" ]; then
    # Run local tests
    echo "Starting local WCT tests"
    bower install
    wct
fi