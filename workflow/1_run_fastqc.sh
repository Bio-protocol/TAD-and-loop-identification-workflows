#!/bin/sh

# normalize your dir to the root level of the repo
# Save the current working directory in an environment variable.
INITIAL_WORKING_DIRECTORY=$(pwd)

# This line changes to current working directory to where
function canonicalPath
{
    local path="$1" ; shift
    if [ -d "$path" ]
    then
        echo "$(cd "$path" ; pwd)"
    else
        local b=$(basename "$path")
        local p=$(dirname "$path")
        echo "$(cd "$p" ; pwd)/$b"
    fi
}

# usage example
mycanonicalpath=$(canonicalPath "$../")

fastqc -o output/ -f fastq -t 1 input/reads1.fastq input/reads1.fastq > output/run.log