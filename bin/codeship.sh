#!/bin/bash

# start debugging/tracing commands, -e - exit if command returns error (non-zero status)
#set -xe

echo "Deploying branch: ${CI_BRANCH}"

branch=${CI_BRANCH}
src=$(git rev-parse --show-toplevel)
base=$(basename ${src})
dest="${base/uqlibrary-/}"

pwd
cd ../${base}
pwd

# stop debugging
#set +x

# Use env vars to set AWS config
awsconfig="aws.json"

# use codeship branch environment variable to push to branch name dir unless it's 'production' branch (or master for now)
if [ ${CI_BRANCH} != "production" ]; then
  export S3BucketSubDir=/${CI_BRANCH}/${dest}
else
  export S3BucketSubDir=${dest}
fi

sed -i -e "s#<AWSAccessKeyId>#${AWSAccessKeyId}#g" ${awsconfig}
sed -i -e "s#<AWSSecretKey>#${AWSSecretKey}#g" ${awsconfig}
sed -i -e "s#<S3Bucket>#${S3Bucket}#g" ${awsconfig}
sed -i -e "s#<S3BucketSubDir>#${S3BucketSubDirVersion}${S3BucketSubDir}#g" ${awsconfig}
sed -i -e "s#<CFDistribution>#${CFDistribution}#g" ${awsconfig}
sed -i -e "s#<AWSRegion>#${AWSRegion}#g" ${awsconfig}

#set -x

#TODO
# if branch == prod or staging do extra minifications, etc
# don't do min for master for better testing/debugging
#run file revision, css min tasks - find gulp alternative for min/rev
#if [ $branch = "staging" ] || [ $branch = "production" ]; then
#  gulp predeploy
#fi

gulp default
gulp publish

rm -f ${awsconfig}
