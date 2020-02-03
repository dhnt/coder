#!/bin/bash
# shopt -s globstar
set -e

source languages.sh

for dockerfile in $(docker_files); do
    image=$(grep ^FROM "$dockerfile" | awk '{print $2}')
    docker pull "$image"
done
