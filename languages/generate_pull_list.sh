#!/bin/bash
# shopt -s globstar
set -e

source languages.sh

for dockerfile in $(docker_files); do
    tagPath=$(dirname "$dockerfile")
    imagePath=$(dirname "$tagPath")
    tag=$(basename "$tagPath")
    image=$(basename "$imagePath")
    imageName="docker.pkg.github.com/dhnt/coder/${image}:${tag}"

    echo "docker pull $imageName"
done
