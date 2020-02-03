#!/bin/bash
# shopt -s globstar
set -e

source languages.sh

for yml in $(faas_files); do
    faas-cli deploy -f $yml
done
