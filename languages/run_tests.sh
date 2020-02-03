#!/bin/bash
set -e

# shopt -s globstar

# Optional argument to test single image
# i.e. glot/python:latest
imageToTest=$1

runTest() {
    image=$1
    payloadFile=$2
    resultFile=$3
    testName="$image - $(basename "$(dirname "$payloadFile")")"

    # image is same as function name
    result=$(faas-cli invoke $image --content-type application/json < "$payloadFile")
    expect=$(cat "$resultFile")

    if [ "$result" == "$expect" ]; then
        echo "OK: $testName"
    else
        echo "FAILED: $testName"
        echo "Result: $result"
        exit 1
    fi
}

source languages.sh

for dockerfilePath in $(docker_files); do
    (
        tagPath=$(dirname "$dockerfilePath")
        imagePath=$(dirname "$tagPath")
        tag=$(basename "$tagPath")
        image=$(basename "$imagePath")
        # imageName="docker.pkg.github.com/dhnt/coder/${image}:${tag}"

        # Change directory to tag path
        cd "$tagPath"

        # Ensure that the tests directory exist
        mkdir -p tests

        # Find and run tests
        for payloadFile in tests/**/payload.json; do
            testPath=$(dirname "$payloadFile")
            resultFile="${testPath}/result.json"

            # If imageToTest is set; run only tests for that image – run all tests if not
            if [ -z "$imageToTest" ] || [ "$imageToTest" == "$image" ] ;then
                runTest "$image" "$payloadFile" "$resultFile"
            fi
        done
    )
done
