#!/bin/bash

languages=(
bash/latest
golang/latest
javascript/latest
python/latest
rust/latest
)

function docker_files() {
    for lang in "${languages[@]}"; do
        echo "$lang/Dockerfile"
    done
}

function faas_files() {
    for lang in "${languages[@]}"; do
        echo "$lang/faas.yml"
    done
}

