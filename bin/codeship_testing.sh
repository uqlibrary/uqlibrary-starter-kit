#!/bin/bash

# start debugging/tracing commands, -e - exit if command returns error (non-zero status)
#set -xe

echo "Testing on branch: "${CI_BRANCH}

branch=${CI_BRANCH}
src=$(git rev-parse --show-toplevel)
base=$(basename ${src})
dest="${base/uqlibrary-/}"

pwd
cd ../${base}
pwd

# build test configuration file

# Get a list of uplibrary-* components
components=$(ls -d bower_components/*/ | grep uqlibrary)

# Add all tests to configuration
testSuites="\"test\""
COUNTER=0

for component in ${components[@]}; do
  # Check if component has a test directory
  cd $component
  if [ -d "test" ]; then
    echo $(pwd)
    testSuites+=" , \""$component"test\""
  fi
  cd ../..
  let COUNTER=COUNTER+1
done

# Detect which remote browsers to use depending on current branch
# Default remote browsers for branches
remoteBrowsers=""
masterRemoteBrowsers="\"OSX 10.10/safari@8.0\""
uatRemoteBrowsers=$masterRemoteBrowsers", \"Windows 8.1/chrome@43.0\""
prodRemoteBrowsers=$uatRemoteBrowsers", \"Windows 8.1/firefox@37.0\",\"Windows 8.1/internet explorer@11.0\""

case "$branch" in
"master")
  remoteBrowsers=$masterRemoteBrowsers
  ;;
"uat")
  remoteBrowsers=$uatRemoteBrowsers
  ;;
"staging")
  remoteBrowsers=$prodRemoteBrowsers
;;
"production")
  remoteBrowsers=$prodRemoteBrowsers
  ;;
*)
  echo "couldn't detect branch, setting to max testing"
  remoteBrowsers=$prodRemoteBrowsers
  ;;
esac


# Update test configuration
wctconfig="wct.conf.json"

# Add test suites
sed -i -e "s#<TestSuites>#${testSuites}#g" $wctconfig
# Add remote browsers
sed -i -e "s#<SauceBrowsers>#${remoteBrowsers}#g" $wctconfig

gulp test:local
gulp test:remote

